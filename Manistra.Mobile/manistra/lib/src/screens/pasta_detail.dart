import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas/pastas_provider.dart';
import 'package:manistra/src/helpers/clipboard_helper.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/widgets/favorite_icon_button.dart';

class PastaDetailScreen extends StatelessWidget with ClipboardHelper {
  final PastaModel _pasta;

  PastaDetailScreen(this._pasta);

  @override
  Widget build(BuildContext context) {
    final bloc = PastasProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          FavoriteIconButton(
            isFavorite: _pasta.isFavorite,
            updateCallback: () => bloc.toggleFavorite(_pasta.id),
          ),
          IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: () => copy(context, _pasta.content),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                _pasta.title,
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
              Text(_pasta.content),
            ],
          ),
        ),
      ),
    );
  }
}
