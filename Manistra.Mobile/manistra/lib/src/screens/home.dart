import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas/pastas_bloc.dart';
import 'package:manistra/src/blocs/pastas/pastas_provider.dart';
import 'package:manistra/src/helpers/auth_helper.dart';
import 'package:manistra/src/pastas_search_delegate.dart';
import 'package:manistra/src/screens/pastas_list.dart';
import 'package:manistra/src/screens/new_pasta.dart';
import 'package:manistra/src/screens/profile.dart';
import 'package:manistra/src/screens/welcome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PastasProvider.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: NewPastaScreen(),
              ),
            ),
          ),
        ),
        appBar: appBar(context, bloc),
        body: TabBarView(
          children: [
            PastasList(bloc.latestPastas, bloc.fetchLatest),
            PastasList(bloc.topPastas, bloc.fetchTop),
            PastasList(bloc.favoritePastas, bloc.fetchFavorites),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context, PastasBloc bloc) {
    var appBar = AppBar(
      bottom: TabBar(
        tabs: [
          Tab(text: 'NEW'),
          Tab(text: 'TOP'),
          Tab(text: 'FAVORITES'),
        ],
      ),
      leading: profileButton(),
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
    );
    return appBar;
  }

  Widget profileButton() {
    return FutureBuilder(
      future: AuthHelper.isAuthorized(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final authenticated = snapshot.data as bool;
          return IconButton(
            icon: Icon(authenticated ? Icons.person : Icons.login),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: authenticated ? ProfileScreen() : WelcomeScreen(),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
