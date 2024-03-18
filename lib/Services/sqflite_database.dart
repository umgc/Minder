
import 'dart:async';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "RemindersDatabase.db";
  static final _databaseVersion = 2;

  static final table = 'reminders';
  static final columnId = 'id';
  static final columnEventType = 'eventType';
  static final columnDescription = 'description';
  static final columnDate = 'date';
  static final columnTime = 'time';

  static String? _databasePath; // Member variable to store the database path

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _databasePath = path; // Store the database path
    print("Database path: $_databasePath"); // Print the database path for debugging
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnEventType TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Database upgrade logic here
  }

  Future<int> insertReminder(Map<String, dynamic> row) async {
  Database db = await database;
  try {
    final int id = await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
    print("Successfully inserted reminder with ID $id.");
    return id; // Return the ID of the inserted row.
  } catch (e) {
    print("Error inserting reminder: $e");
    return -1; // Returning -1 to indicate failure.
  }
}


   Future<List<Map<String, dynamic>>> queryAllReminders() async {
    Database db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRemindersByEventType(String eventType) async {
    Database db = await database;
    return await db.query(table, where: '$columnEventType = ?', whereArgs: [eventType]);
  }

   Future<int> updateReminder(Map<String, dynamic> updatedReminderMap) async {
  Database db = await database;
  
  // Check if 'id' is null and log an error if it is.
  if (updatedReminderMap['id'] == null) {
    print("Error: Attempting to update a reminder without a valid ID.");
    return -1; // Indicates an error due to invalid ID.
  }
  
  // Extract the 'id' and log it for debugging purposes.
  int id = updatedReminderMap['id'];
  print("Updating reminder with ID: $id"); // Log the 'id' being used for the update.
  
  // Optionally, log the entire map to see all values being updated.
  print("Updated values: $updatedReminderMap");
  
  // Perform the update operation.
  int result = await db.update(
    table,
    updatedReminderMap,
    where: '$columnId = ?',
    whereArgs: [id],
  );
  
  // Log the result of the update operation.
  print("Number of rows affected: $result");
  
  return result;
}




  Future<int> deleteReminder(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<List<Reminder>> getAllReminders() async {
  Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query(table);
  return List.generate(maps.length, (i) {
    return Reminder(
      id: maps[i][columnId],
      eventType: maps[i][columnEventType],
      description: maps[i][columnDescription],
      date: maps[i][columnDate],
      time: maps[i][columnTime],
    );
  });

  
}
Future<Reminder?> getReminderById(int id) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> reminders = await db.query(table,
      where: '$columnId = ?', whereArgs: [id], limit: 1);

  if (reminders.isNotEmpty) {
    return Reminder(
      id: reminders.first[columnId],
      eventType: reminders.first[columnEventType],
      description: reminders.first[columnDescription],
      date: reminders.first[columnDate],
      time: reminders.first[columnTime],
    );
  } else {
    return null; // Return null if no reminder is found with the specified ID
  }
}

}
