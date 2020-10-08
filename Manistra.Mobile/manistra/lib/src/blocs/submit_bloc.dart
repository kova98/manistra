import 'dart:async';
import 'package:manistra/src/blocs/submit_validators.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SubmitBloc with SubmitValidators {
  final _repo = Repository();
  final _title = BehaviorSubject<String>();
  final _content = BehaviorSubject<String>();

  Stream<String> get title => _title.stream.transform(validateTitle);
  Stream<String> get content => _content.stream.transform(validateContent);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(title, content, (e, p) => true);

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeContent => _content.sink.add;

  Future<PastaModel> submit() async {
    final pasta = PastaModel(
      title: _title.value,
      content: _content.value,
    );

    return _repo.submitPasta(pasta);
  }

  dispose() {
    _title.close();
    _content.close();
  }
}
