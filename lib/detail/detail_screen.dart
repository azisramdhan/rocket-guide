import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketDetailsScreen extends StatelessWidget {
  const RocketDetailsScreen({Key key, @required this.rocket})
      : assert(rocket != null),
        super(key: key);

  final Rocket rocket;

  bool get _hasAlreadyFlown => rocket.firstFlight.isBefore(DateTime.now());

  int get _daysSinceFirstFlight =>
      rocket.firstFlight.difference(DateTime.now()).abs().inDays;

  String get _firstFlightLabel {
    final date = rocket.firstFlight;

    return '${date.year}-${date.month}-${date.day}';
  }

  String get _firstFlightLabelFormatted =>
      DateFormat.yMMMd().format(rocket.firstFlight);

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
          ListTile(
            title: Text(
              rocket.name,
              style: textTheme.headline5,
            ),
            subtitle: rocket.active ? null : Text('Inactive'),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(rocket.description, style: textTheme.subtitle2)),
          ListTile(
            leading: const Icon(AntIcons.calendar_outline),
            title: Text(_hasAlreadyFlown
                ? '$_daysSinceFirstFlight days since first flight'
                : '$_daysSinceFirstFlight days until first flight'),
            subtitle: Text(_hasAlreadyFlown
                ? 'First flew on $_firstFlightLabelFormatted'
                : 'Scheduled to fly on $_firstFlightLabelFormatted'),
          ),
          Divider(),
          ListTile(
            leading: Icon(AntIcons.column_width),
            title: Text('${rocket.diameter} m'),
            subtitle: Text('in diameter'),
          ),
          Divider(),
          ListTile(
            leading: Icon(AntIcons.colum_height),
            title: Text('${rocket.height} m'),
            subtitle: Text('in height'),
          ),
          Divider(),
          ListTile(
            leading: Icon(AntIcons.arrow_down),
            title: Text('${rocket.mass} kg'),
            subtitle: Text('total mass'),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              height: 56.0,
              child: ElevatedButton(
                  onPressed: () {
                    launch(rocket.wikipedia);
                  },
                  child: Text('Open Wikipedia Article')),
            ),
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
