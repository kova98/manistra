import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_provider.dart';
import 'package:manistra/src/screens/pastas_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manistra'),
      ),
      body: PastasList(),
    );
  }
}
