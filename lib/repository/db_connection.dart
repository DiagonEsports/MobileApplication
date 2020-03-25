import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_diagon');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE slips(id INTEGER PRIMARY KEY, )");
  }
}
