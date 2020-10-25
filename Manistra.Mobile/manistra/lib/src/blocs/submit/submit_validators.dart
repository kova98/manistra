import 'dart:async';

class SubmitValidators {
  final validateTitle = StreamTransformer<String, String>.fromHandlers(
    handleData: (title, sink) {
      if (title.length > 5) {
        sink.add(title);
      } else {
        sink.addError('Title must be at least 3 characters long');
      }
    },
  );

  final validateContent = StreamTransformer<String, String>.fromHandlers(
    handleData: (content, sink) {
      if (content.length > 20) {
        sink.add(content);
      } else {
        sink.addError('Content must be at least 20 characters long');
      }
    },
  );
}
