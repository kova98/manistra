import 'package:flutter/material.dart';
import 'package:manistra/src/models/pasta_model.dart';

class PastaDetailScreen extends StatelessWidget {
  final PastaModel pasta;

  PastaDetailScreen(this.pasta);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                pasta.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'by anonymous',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
              ),
              Text(pasta.content),
            ],
          ),
        ),
      ),
    );
  }
}
