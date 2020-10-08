class PastaModel {
  final int id;
  final String title;
  final String content;
  final bool isFavorite;
  final int favoriteCount;
  final String dateCreated;

  PastaModel(
      {this.title,
      this.content,
      this.id,
      this.isFavorite,
      this.favoriteCount,
      this.dateCreated});

  PastaModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'],
        isFavorite = parsedJson['isFavorite'],
        favoriteCount = parsedJson['favoriteCount'],
        dateCreated = parsedJson['dateCreated'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "title": title,
        "content": content,
        "isFavorite": isFavorite ? 1 : 0,
        "favoriteCount": favoriteCount,
        "dateCreated": dateCreated
      };

  PastaModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        title = parsedJson['title'],
        content = parsedJson['content'],
        isFavorite = parsedJson['isFavorite'] == 1,
        favoriteCount = parsedJson['favoriteCount'],
        dateCreated = parsedJson['dateCreated'];
}
