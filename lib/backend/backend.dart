import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Backend {
  const Backend(this.hostUrl);

  final String hostUrl;

  Stream<User> get currentUserStream => FirebaseAuth.instance.userChanges();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signUp() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Stream<List<String>> get favouritedRocket {
    final userId = FirebaseAuth.instance.currentUser.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((documentSnapshot) {
      if (!documentSnapshot.exists) {
        return [];
      }
      return List<String>.from(documentSnapshot.data()['favorited_rocket']);
    });
  }

  Future<List<Rocket>> getRockets() async {
    final url = Uri.parse('$hostUrl/rockets');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final body = response.body;
    final jsonData = json.decode(body) as List;
    final rockets = jsonData.map((jsonMap) {
      return Rocket(
          id: jsonMap['id'],
          name: jsonMap['name'],
          description: jsonMap['description'],
          active: jsonMap['active'],
          boosters: jsonMap['boosters'],
          flickrImages: List<String>.from(jsonMap['flickr_images']),
          diameter: (jsonMap['diameter']['meters'] as num).toDouble(),
          firstFlight: DateTime.parse(jsonMap['first_flight']),
          height: (jsonMap['height']['meters'] as num).toDouble(),
          mass: jsonMap['mass']['kg'],
          wikipedia: jsonMap['wikipedia']);
    }).toList();

    return rockets;
  }

  Future<void> setFavoritedRocket(
      {@required String id, @required bool favorited}) async {
    final currentFavoritedRockets = await favouritedRocket.first;
    print(currentFavoritedRockets);
    if (favorited && !currentFavoritedRockets.contains(id)) {
      currentFavoritedRockets.add(id);
    } else if (!favorited && currentFavoritedRockets.contains(id)) {
      currentFavoritedRockets.remove(id);
    }
    print(currentFavoritedRockets);

    final userId = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'favorited_rocket': currentFavoritedRockets});
  }
}

class Rocket {
  const Rocket(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.active,
      @required this.boosters,
      @required this.flickrImages,
      @required this.wikipedia,
      @required this.firstFlight,
      @required this.diameter,
      @required this.height,
      @required this.mass})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(active != null),
        assert(boosters != null),
        assert(flickrImages != null),
        assert(wikipedia != null),
        assert(firstFlight != null),
        assert(diameter != null),
        assert(height != null),
        assert(mass != null);

  final String id;
  final String name;
  final String description;
  final List<String> flickrImages;
  final bool active;
  final int boosters;
  final String wikipedia;
  final DateTime firstFlight;
  final double diameter;
  final double height;
  final int mass;
}
