import 'package:flutter/material.dart';
import 'package:manistra/src/screens/home.dart';
import 'package:manistra/src/screens/pastas_list.dart';

import 'blocs/pastas_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return PastasProvider(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        title: 'Manistra',
        home: Home(),
      ),
    );
  }
}
