// database_handler.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  late Database _database;

  Future<void> initializeDB() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> insertContact(Map<String, dynamic> contact) async {
    // Ensure the database is initialized before inserting
    await initializeDB();
    return await _database.insert('contacts', contact);
  }

  Future<List<Map<String, dynamic>>> retrieveContacts() async {
    // Ensure the database is initialized before retrieving
    await initializeDB();
    return await _database.query('contacts');
  }

  Future<int> updateContact(Map<String, dynamic> contact) async {
    // Ensure the database is initialized before updating
    await initializeDB();
    return await _database.update(
      'contacts',
      contact,
      where: 'id = ?',
      whereArgs: [contact['id']],
    );
  }

  Future<int> deleteContact(int id) async {
    // Ensure the database is initialized before deleting
    await initializeDB();
    return await _database.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
