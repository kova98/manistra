import 'package:flutter/material.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/screens/pasta_detail.dart';

class PastasListTile extends StatelessWidget {
  final PastaModel pasta;

  PastasListTile({this.pasta});

  Widget build(context) {
    return Column(
      children: [
        ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PastaDetailScreen(pasta),
            ),
          ),
          title: Text(pasta.title),
          subtitle: Text(pasta.content),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border),
              Text('0'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
