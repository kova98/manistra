class PastaModel {
  final int id;
  final String title;
  final String content;

  PastaModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": content,
    };
  }
}
