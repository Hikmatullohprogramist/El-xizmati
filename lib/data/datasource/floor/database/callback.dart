import 'dart:io';

import 'package:floor/floor.dart';

Callback get databaseCallback => Callback(
    onCreate: (database, version) {
      // Called when the database is created for the first time.
    },
    onUpgrade: (database, startVersion, endVersion) async {
      // Called when the database needs to be upgraded.
      if (endVersion == 2) {
        // final databasePath = database.path;
        // await database.close();
        // await File(databasePath).delete();

        // Check for the specific version where you want the destructive migration.
        // await database.execute("DROP TABLE IF EXISTS ads"); // Drop the existing table
        // Re-create the table with the updated schema (or let Floor do it automatically).
      }
    },
    onOpen: (database) async {
      // Called when the database is opened.
    }
);