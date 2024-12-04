import 'package:firebaseauth111/lib1/model/category.dart';
import 'package:path/path.dart';
// import 'package:shoppio_flutter_app/model/category.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // database name
  static final String _dbName = 'shoppio.db';

  // database version
  static int _dbVersion = 1;

  // tables name
  static final String _tableCategory = 'category';

  // Column names
  static final String _id = 'id';
  static final String _title = 'title';
  static final String _desc = 'description';
  static final String _image = 'image';

  /*static final String _image = 'image_path';*/
  static final String _date = 'date';

  static Database? _database;

  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper(){
    return _instance;
  }

  DbHelper._internal();

  Future<Database?> getDatabase() async {
    if (_database == null) {
      _database = await createDatabase();
    }
    return _database;
  }

  Future<Database> createDatabase() async {
    var path = join(await getDatabasesPath(), _dbName);
    print('database path : $path');
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE $_tableCategory('
            '$_id INTEGER PRIMARY KEY AUTOINCREMENT , '
            '$_title TEXT, '
            '$_desc TEXT, '
            '$_image TEXT,'
            '$_date INTEGER )');
      },
    );
  }

  Future<int?> insert(Category category) async {
    final db = await getDatabase();
    return await db?.insert(_tableCategory, category.toMap());
  }

  Future<List<Category>> getCategoryList() async {
    List<Category> categoryList = [];

    final db = await getDatabase();
    //List<Map<String,dynamic>> list = await db!.query(_tableCategory);
    // var list = await db!.query(_tableCategory);
    final List<Map<String, dynamic>> list =
        await db!.rawQuery('select * from $_tableCategory');

    // Convert the List<Map<String, dynamic> into a List<Category>.
    categoryList = List.generate(list.length, (index) => Category.fromMap(list[index])).toList();
    return categoryList;
  }

  Future<int> update(Category category) async {
    final db = await getDatabase();
    //db!.update(_tableCategory, category.toMap(), where: '$_id = ? and $_title = ?');
    return await db!.update(_tableCategory, category.toMap(), where: '$_id = ?', whereArgs: [category.id]);

  }

  Future<int> delete(int id) async {
    final db = await getDatabase();
    return await db!.delete(_tableCategory, where: '$_id = ?', whereArgs: [id]);

  }
}
