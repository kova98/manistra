import 'package:manistra/src/models/pasta_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class ManistraDbProvider {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await init();
    return _db;
  }

  Future<Database> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "manistra2.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Pastas
            (
              id INTEGER PRIMARY KEY,
              title TEXT,
              content TEXT,
              isFavorite INTEGER,
              favoriteCount INTEGER,
              dateCreated TEXT
            )
        """);
      },
    );
  }

  Future<List<PastaModel>> fetchPastas(String orderBy) async {
    final database = await db;
    final maps = await database.query(
      "Pastas",
      columns: null,
      orderBy: convertOrderByColumn(orderBy),
    );

    if (maps.length > 0) {
      return maps.map((e) => PastaModel.fromDb(e)).toList();
    }

    return null;
  }

  void addPastas(List<PastaModel> pastas) async {
    final database = await db;
    final batch = database.batch();

    pastas.forEach((pasta) {
      batch.insert("Pastas", pasta.toMap());
    });

    batch.commit();
  }

  Future<int> clear() async {
    final database = await db;
    return database.delete("Pastas");
  }

  Future toggleFavorite(int id) async {
    final database = await db;

    final maps = await database.query(
      "Pastas",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    final pasta = maps.first;
    final isFavorite = pasta['isFavorite'] as int;
    final favoriteCount = pasta['favoriteCount'] as int;

    final invertedIsFavorite = isFavorite == 1 ? 0 : 1;
    final newFavoriteCount = updateFavoriteCount(favoriteCount, isFavorite);

    final row = {
      "isFavorite": invertedIsFavorite,
      "favoriteCount": newFavoriteCount,
    };

    database.update(
      "Pastas",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  int updateFavoriteCount(int favoriteCount, int isFavorite) {
    if (isFavorite == 1) {
      favoriteCount--;
    } else {
      favoriteCount++;
    }

    return favoriteCount;
  }

  String convertOrderByColumn(String column) {
    switch (column) {
      case "favoriteCount_descending":
        return "favoriteCount DESC";
      case "date_descending":
        return "datetime(dateCreated) DESC";
      default:
        throw Exception('Invalid orderBy string.');
    }
  }
}
