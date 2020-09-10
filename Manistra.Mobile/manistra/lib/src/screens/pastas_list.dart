import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_provider.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/widgets/pastas_list_tile.dart';

class PastasList extends StatelessWidget {
  Widget build(context) {
    final bloc = PastasProvider.of(context);

    return StreamBuilder(
      stream: bloc.pastas,
      builder: (context, AsyncSnapshot<List<PastaModel>> snapshot) {
        if (!snapshot.hasData) {
          bloc.fetchPastas();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                return PastasListTile(
                  pasta: snapshot.data[index],
                );
              },
            ),
            onRefresh: () async {
              await bloc.fetchPastas();
            },
          );
        }
      },
    );
  }
}
