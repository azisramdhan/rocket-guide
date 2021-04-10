import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final backend = Backend('https://api.spacexdata.com/v4');
  runApp(RocketGuideApp(
    backend: backend,
  ));
}
