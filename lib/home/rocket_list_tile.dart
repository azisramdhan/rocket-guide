import 'package:flutter/material.dart';
import 'package:rocket_guide/backend/backend.dart';

class RocketListTile extends StatelessWidget {
  const RocketListTile({Key key, @required this.onTap, @required this.rocket})
      : assert(rocket != null),
        super(key: key);

  final VoidCallback onTap;
  final Rocket rocket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: rocket.flickrImages.isEmpty
          ? null
          : AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: 'hero-${rocket.id}-image',
                child: Image.network(
                  rocket.flickrImages.first,
                  fit: BoxFit.cover,
                ),
              )),
      isThreeLine: true,
      title: Text(rocket.name),
      subtitle: Text(
        rocket.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.chevron_right_sharp),
    );
  }
}
