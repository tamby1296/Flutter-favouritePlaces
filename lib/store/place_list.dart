import 'dart:io';

import 'package:demo6/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  return await sql.openDatabase(
    path.join(dbPath, 'favoritePlaces.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
    version: 1,
  );
}

class PlaceListNotifier extends StateNotifier<List<Place>> {
  PlaceListNotifier() : super([]);

  void addFavoritePlace(Place p) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(p.image.path);
    final copiedImage = await p.image.copy('${appDir.path}/$filename');
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': p.id,
      'title': p.name,
      'image': p.image.path,
    });

    p.image = copiedImage;
    state = [...state, p];
  }

  Future<void> loadFavoritePlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final loadedPlaces = data.map(
      (row) => Place(
        id: row['id'] as String,
        name: row['title'] as String,
        image: File(row['image'] as String),
      ),
    ).toList();

    state = loadedPlaces;
  }
}

final placeListProvider = StateNotifierProvider((ref) => PlaceListNotifier());
