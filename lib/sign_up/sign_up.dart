import 'package:flutter/material.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To',
              style: textTheme.headline5,
            ),
            Text(
              'Rocket Guide',
              style: textTheme.headline4,
            ),
            SizedBox(
              height: 16.0,
            ),
            ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        final backend = context.read<Backend>();
                        backend.signUp();
                        setState(() {
                          isLoading = true;
                        });
                      },
                icon: Icon(Icons.app_registration),
                label:
                    isLoading ? CircularProgressIndicator() : Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
