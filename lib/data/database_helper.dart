import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/album.dart';
import 'models/photo.dart';

class DatabaseHelper {
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'albums_images.db');

    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE albums (
          id INTEGER PRIMARY KEY,
          title TEXT
        )
      ''');

      db.execute('''
        CREATE TABLE images (
          id INTEGER PRIMARY KEY,
          albumId INTEGER,
          url TEXT
        )
      ''');
    });
  }

  Future<void> insertAlbums(List<Album> albums) async {
    final db = await database;
    for (var album in albums) {
      await db.insert(
        'albums',
        album.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertImages(List<Photo> images) async {
    final db = await database;
    for (var image in images) {
      await db.insert(
        'images',
        image.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Album>> getAlbums() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('albums');
    return List.generate(maps.length, (i) {
      return Album.fromJson(maps[i]);
    });
  }

  Future<List<Photo>> getImages(int albumId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'images',
      where: 'albumId = ?',
      whereArgs: [albumId],
    );
    return List.generate(maps.length, (i) {
      return Photo.fromJson(maps[i]);
    });
  }
}
