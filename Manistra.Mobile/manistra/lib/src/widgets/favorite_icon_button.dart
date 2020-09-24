import 'package:flutter/material.dart';

class FavoriteIconButton extends StatefulWidget {
  final Future<bool> Function() updateCallback;
  final bool isFavorite;

  @override
  FavoriteIconButtonState createState() =>
      FavoriteIconButtonState(updateCallback, isFavorite);

  FavoriteIconButton({this.updateCallback, this.isFavorite});
}

class FavoriteIconButtonState extends State<FavoriteIconButton> {
  final Future<bool> Function() _updateCallback;
  bool _isFavorited = false;

  FavoriteIconButtonState(this._updateCallback, this._isFavorited);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: _isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
        onPressed: () {
          _toggleFavorite();
          _showSnackbar();
          _updateCallback();
        });
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  void _showSnackbar() {
    final scaffoldState = Scaffold.of(context);

    scaffoldState.hideCurrentSnackBar();
    scaffoldState.showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited ? 'Added to favorites.' : 'Removed from favorites.',
        ),
      ),
    );
  }
}
