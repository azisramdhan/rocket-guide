import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:provider/provider.dart';

class RocketListTile extends StatelessWidget {
  const RocketListTile({Key key, @required this.onTap, @required this.rocket})
      : assert(rocket != null),
        super(key: key);

  final VoidCallback onTap;
  final Rocket rocket;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: context.read<Backend>().favouritedRocket,
      builder: (context, snapshot) {
        final hasFavorited =
            snapshot.hasData && snapshot.data.contains(rocket.id);

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
          title: Row(
            children: [
              Hero(tag: 'hero-${rocket.name}-name', child: Text(rocket.name)),
              if (hasFavorited) ...const [
                SizedBox(
                  width: 4.0,
                ),
                Icon(
                  AntIcons.heart,
                  color: Colors.redAccent,
                  size: 16.0,
                )
              ]
            ],
          ),
          subtitle: Text(
            rocket.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.chevron_right_sharp),
        );
      },
    );
  }
}
