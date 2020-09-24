import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/widgets/pastas_list_tile.dart';

class PastasList extends StatelessWidget {
  final Stream<List<PastaModel>> stream;
  final Function refresh;

  PastasList(this.stream, this.refresh);

  Widget build(context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<List<PastaModel>> snapshot) {
        if (!snapshot.hasData) {
          refresh();
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
            onRefresh: () => refresh(),
          );
        }
      },
    );
  }
}
