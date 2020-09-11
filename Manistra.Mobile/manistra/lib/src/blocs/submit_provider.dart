import 'package:flutter/material.dart';
import 'package:manistra/src/blocs/submit_bloc.dart';

class SubmitProvider extends InheritedWidget {
  final bloc = SubmitBloc();

  SubmitProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SubmitBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubmitProvider>().bloc;
  }
}
