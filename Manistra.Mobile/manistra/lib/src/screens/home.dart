import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_provider.dart';
import 'package:manistra/src/pastas_search_delegate.dart';
import 'package:manistra/src/screens/pastas_list.dart';

import 'new_pasta.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PastasProvider.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: NewPastaScreen(),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Center(
          child: Text('manistra'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PastasSearchDelegate(bloc),
              );
            },
          )
        ],
      ),
      body: PastasList(),
    );
  }
}
