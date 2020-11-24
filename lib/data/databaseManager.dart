import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Database database;

  Future<void> fireUpDatabase()async{
    database = await openDatabase('Favourites.db');
  }
   Future<void> createTables() async {
    await database.execute('CREATE TABLE IF NOT EXISTS Characters (id VARCHAR)');
    await database.execute('CREATE TABLE IF NOT EXISTS Locations (id VARCHAR)');
    await database.execute('CREATE TABLE IF NOT EXISTS Episodes (id VARCHAR)');
  }

   Future<int> addFavouriteCharacter(String id) async {
    int count = await database.rawInsert('INSERT INTO Characters(id) VALUES (?)', [id]);
    return count;
  }

  Future<int> addFavouriteLocation(String id) async {
    int count = await database.rawInsert('INSERT INTO Locations(id) VALUES (?)', [id]);
    return count;
  }

   Future<int> addFavouriteEpisodes(String id) async {
    int count = await database.rawInsert('INSERT INTO Episodes(id) VALUES (?)', [id]);
    return count;
  }

   Future<List<Map<String, dynamic>>> fetchFavouriteCharacters() async {
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Characters');
    return saved;
  }

   Future<List<Map<String, dynamic>>> fetchFavouriteLocations() async {
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Locations');
    return saved;
  }

   Future<List<Map<String, dynamic>>> fetchFavouriteEpisode() async {
    List<Map<String, dynamic>> saved = await database.rawQuery('SELECT * FROM Episodes');
    return saved;
  }

   Future<int> deleteCharacter(String id) async {
    int count = await database.rawDelete('DELETE FROM Characters WHERE id = ?', [id]);
    return count;
  }

   Future<int> deleteLocation(String id) async {
    int count = await database.rawDelete('DELETE FROM Locations WHERE id = ?', [id]);
    return count;
  }

   Future<int> deleteEpisode(String id) async {
    int count = await database.rawDelete('DELETE FROM Episodes WHERE id = ?', [id]);
    return count;
  }
}
