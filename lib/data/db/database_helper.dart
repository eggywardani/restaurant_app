import 'package:restaurant_app/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tableName = "restaurants";

  Future<Database?> _initializeDatabase() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase("$path/restaurantsapp.db", onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableName (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating TEXT
           )     
        ''');
    }, version: 1);

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database;
  }

  Future<void> insertRestaurant(Restaurants restaurants) async {
    final db = await database;
    await db?.insert(_tableName, restaurants.toJson());
  }

  Future<List<Restaurants>> getRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableName);

    return results.map((e) => Restaurants.fromJson(e)).toList();
  }

  Future<Map> getRestaurantById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeRestaurant(String id) async {
    final db = await database;

    await db?.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
