import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static Future<void> createTables() async {
    final database = await openDatabase('Favourites.db');
    database.execute('CREATE TABLE IF NOT EXISTS Characters (id VARCHAR)');
    database.execute('CREATE TABLE IF NOT EXISTS Locations (id VARCHAR)');
    database.execute('CREATE TABLE IF NOT EXISTS Episodes (id VARCHAR)');
    database.close();
  }

  static Future<int> addFavouriteCharacter(String id) async {
    final database = await openDatabase('Favourites.db');
    int count = await database.rawInsert('INSERT INTO Characters(id) VALUES (?)', [id]);
    database.close();
    return count;
  }

  static Future<int> addFavouriteLocation(String id) async {
    final database = await openDatabase('Favourites.db');
    int count = await database.rawInsert('INSERT INTO Locations(id) VALUES (?)', [id]);
    database.close();
    return count;
  }

  static Future<int> addFavouriteEpisodes(String id) async {
    final database = await openDatabase('Favourites.db');
    int count = await database.rawInsert('INSERT INTO Episodes(id) VALUES (?)', [id]);
    database.close();
    return count;
  }

  static Future<List<Map<String, dynamic>>> fetchFavouriteCharacters() async {
    final database = await openDatabase('Favourite.db');
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Characters');
    database.close();
    return saved;
  }

  static Future<List<Map<String, dynamic>>> fetchFavouriteLocations() async {
    final database = await openDatabase('Favourite.db');
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Locations');
    database.close();
    return saved;
  }

  static Future<List<Map<String, dynamic>>> fetchFavouriteEpisode() async {
    final database = await openDatabase('Favourite.db');
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Episodes');
    database.close();
    return saved;
  }

  static Future<int> deleteCharacter(String id) async {
    final database = await openDatabase('Favourite.db');
    int count = await database.rawDelete('DELETE FROM Characters WHERE id = ?', [id]);
    database.close();
    return count;
  }

  static Future<int> deleteLocation(String id) async {
    final database = await openDatabase('Favourite.db');
    int count = await database.rawDelete('DELETE FROM Locations WHERE id = ?', [id]);
    database.close();
    return count;
  }

  static Future<int> deleteEpisode(String id) async {
    final database = await openDatabase('Favourite.db');
    int count = await database.rawDelete('DELETE FROM Episodes WHERE id = ?', [id]);
    database.close();
    return count;
  }
}
