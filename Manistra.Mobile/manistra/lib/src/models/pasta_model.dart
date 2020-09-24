class PastaModel {
  final int id;
  final String title;
  final String content;
  final bool isFavorite;
  final int favoriteCount;

  PastaModel(
      {this.title, this.content, this.id, this.isFavorite, this.favoriteCount});

  PastaModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'],
        isFavorite = parsedJson['isFavorite'],
        favoriteCount = parsedJson['favoriteCount'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "title": title,
        "content": content,
        "isFavorite": isFavorite,
        "favoriteCount": favoriteCount
      };
}
