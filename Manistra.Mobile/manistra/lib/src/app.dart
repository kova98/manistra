import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas/pastas_provider.dart';
import 'package:manistra/src/blocs/submit/submit_provider.dart';
import 'package:manistra/src/helpers/auth_helper.dart';
import 'package:manistra/src/screens/home.dart';
import 'package:manistra/src/screens/welcome.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return PastasProvider(
      child: SubmitProvider(
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            title: 'Manistra',
            home: FutureBuilder(
              future: AuthHelper.isAuthorized(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ? Home() : WelcomeScreen();
                } else {
                  return Scaffold(
                    backgroundColor: Colors.amber,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
