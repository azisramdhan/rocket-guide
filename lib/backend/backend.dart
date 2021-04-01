import 'package:meta/meta.dart';

class Backend {
  const Backend(this.hostUrl);

  final String hostUrl;
  Future<List<Rocket>> getRockets() async {
    return const [
      Rocket(
        id: 'flacon_1',
        name: 'Falcon 1',
        description: 'The Falcon 1 was an expendable launch system privately '
            'developed and manufactured by SpaceX during 2006-2009. '
            'On 28 September 2008, Falcon 1 became the first '
            'privately-developed liquid-fuel launch vehicle to go into orbit '
            'around the Earth.',
        active: false,
        boosters: 0,
        flickrImages: [
          'https://imgur.com/DaCfMsj.jpg',
          'https://imgur.com/azYafd8.jpg',
        ],
      )
    ];
  }
}

class Rocket {
  const Rocket(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.active,
      @required this.boosters,
      this.flickrImages = const []})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(active != null),
        assert(boosters != null),
        assert(flickrImages != null);

  final String id;
  final String name;
  final String description;
  final List<String> flickrImages;
  final bool active;
  final int boosters;
}
