import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_provider.dart';
import 'package:manistra/src/blocs/submit_provider.dart';
import 'package:manistra/src/screens/home.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return PastasProvider(
      child: SubmitProvider(
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          title: 'Manistra',
          home: Home(),
        ),
      ),
    );
  }
}
