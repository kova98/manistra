import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_bloc.dart';
import 'package:manistra/src/screens/pastas_list.dart';

class PastasSearchDelegate extends SearchDelegate {
  final PastasBloc bloc;

  PastasSearchDelegate(this.bloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.searchQuery = query;
    bloc.searchPastas();

    return PastasList(bloc.searchResults, bloc.searchPastas());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
