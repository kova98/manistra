class PastaModel {
  final int id;
  final String title;
  final String content;
  final bool isFavorite;

  PastaModel({this.title, this.content, this.id, this.isFavorite});

  PastaModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'],
        isFavorite = parsedJson['isFavorite'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "title": title,
        "content": content,
        "isFavorite": isFavorite
      };
}
