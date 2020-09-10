import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/pastas_bloc.dart';

class PastasProvider extends InheritedWidget {
  final PastasBloc bloc;

  PastasProvider({Key key, Widget child})
      : bloc = PastasBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static PastasBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PastasProvider>().bloc;
  }
}
