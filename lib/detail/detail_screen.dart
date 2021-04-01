import 'package:flutter/material.dart';
import 'package:rocket_guide/backend/backend.dart';

class RocketDetailsScreen extends StatelessWidget {
  const RocketDetailsScreen({Key key, @required this.rocket})
      : assert(rocket != null),
        super(key: key);

  final Rocket rocket;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(rocket.name),
      ),
      body: ListView(
        children: [
          if (rocket.flickrImages.isNotEmpty)
            Hero(
                tag: 'hero-${rocket.id}-image',
                child: _HeaderImage(images: rocket.flickrImages)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              rocket.name,
              style: textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(rocket.description, style: textTheme.subtitle2),
          )
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({Key key, @required this.images}) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: PageView(children: [
          for (final image in images)
            Image.network(
              image,
              fit: BoxFit.cover,
            )
        ]));
  }
}
