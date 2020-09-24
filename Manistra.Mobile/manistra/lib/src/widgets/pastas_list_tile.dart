import 'package:flutter/material.dart';
import 'package:manistra/src/helpers/clipboard_helper.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/screens/pasta_detail.dart';

class PastasListTile extends StatelessWidget with ClipboardHelper {
  final PastaModel pasta;

  PastasListTile({this.pasta});

  Widget build(context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: PastaDetailScreen(pasta),
                ),
              ),
            ),
            onLongPress: () => copy(context, pasta.content),
            title: Text(
              pasta.title,
              style: TextStyle(fontSize: 18),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pasta.isFavorite
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                Text('0'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
