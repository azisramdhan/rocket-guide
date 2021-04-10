import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_guide/app/theme.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:rocket_guide/home/home_screen.dart';
import 'package:rocket_guide/sign_up/sign_up.dart';

class RocketGuideApp extends StatelessWidget {
  const RocketGuideApp({Key key, @required this.backend})
      : assert(backend != null),
        super(key: key);
  final Backend backend;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provider.value(
        value: backend,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          home: StreamBuilder<User>(
            stream: backend.currentUserStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SignUpScreen();
              }
              return HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
