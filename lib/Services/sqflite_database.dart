  // Contributors: 
    // Developed by: Elsa Bushen 

import 'dart:async';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


/// A helper class to manage database operations for reminders.
class DatabaseHelper {
  // Database configuration
  static final _databaseName = "RemindersDatabase.db";
  static final _databaseVersion = 2;

  // Table and column names
  static final table = 'reminders';
  static final columnId = 'id';
  static final columnEventType = 'eventType';
  static final columnDescription = 'description';
  static final columnDate = 'date';
  static final columnTime = 'time';

  // Stores the path to the database file
  static String? _databasePath; 
  
  //Private constructor for the singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // The single database instance
  static Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

///  Defines the schema of the database on its creation.
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

/// Initializes the database schema when the database is first created.
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

/// Handles database upgrades when the version changes.
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Database upgrade logic will be added in future releases. 
  }

/// Inserts a new reminder into the database.
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

/// Queries all reminders from the database.
   Future<List<Map<String, dynamic>>> queryAllReminders() async {
    Database db = await database;
    return await db.query(table);
  }

/// Queries reminders by their event type.
  Future<List<Map<String, dynamic>>> queryRemindersByEventType(String eventType) async {
    Database db = await database;
    return await db.query(table, where: '$columnEventType = ?', whereArgs: [eventType]);
  }

/// Updates a specific reminder by id.
   Future<int> updateReminder(Map<String, dynamic> updatedReminderMap) async {
  Database db = await database;
  
  // Check if 'id' is null and log an error if it is.
  if (updatedReminderMap['id'] == null) {
    print("Error: Attempting to update a reminder without a valid ID.");
    return -1; // Indicates an error due to invalid ID.
  }

  // Extract the 'id' and log it for debugging purpose.
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



/// Deletes a specific reminder by id.
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
/// Retrieves a reminder from the database by its unique identifier (ID).
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
    return null; 
  }
}

}
