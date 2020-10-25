import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/submit/submit_bloc.dart';
import 'package:manistra/src/blocs/submit/submit_provider.dart';
import 'package:manistra/src/screens/pasta_detail.dart';

class NewPastaScreen extends StatelessWidget {
  @override
  Widget build(context) {
    final bloc = SubmitProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Submit Pasta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            titleField(bloc),
            contentField(bloc),
            Container(margin: EdgeInsets.only(top: 20)),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget titleField(SubmitBloc bloc) {
    return StreamBuilder(
      stream: bloc.title,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeTitle,
          decoration: InputDecoration(
            hintText: 'a nice, descriptive title',
            labelText: 'title',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget contentField(SubmitBloc bloc) {
    return StreamBuilder(
      stream: bloc.content,
      builder: (context, snapshot) {
        return TextField(
          minLines: 1,
          maxLines: 10,
          keyboardType: TextInputType.multiline,
          onChanged: bloc.changeContent,
          decoration: InputDecoration(
            hintText: 'your hilarious pasta',
            labelText: 'content',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget submitButton(SubmitBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Submit'),
          color: Colors.amber,
          onPressed: () async {
            if (snapshot.hasData) {
              final pasta = await bloc.submit();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PastaDetailScreen(pasta);
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
