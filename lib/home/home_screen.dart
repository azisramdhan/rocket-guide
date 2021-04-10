import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:rocket_guide/detail/detail_screen.dart';
import 'package:rocket_guide/home/rocket_list_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<Backend>().signOut();
              }),
          title: Text('Rocket Guide'),
        ),
        body: FutureBuilder<List<Rocket>>(
          future: Provider.of<Backend>(context).getRockets(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Oops!'));
            } else if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final data = snapshot.data;
              // return Center(child: Text('$data'));
              return ListView(
                children: [
                  for (final rocket in data)
                    RocketListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RocketDetailsScreen(
                                  rocket: rocket,
                                )));
                      },
                      rocket: rocket,
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
