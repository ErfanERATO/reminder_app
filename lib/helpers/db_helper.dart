import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'checks.db'),
        onCreate: (db, version) {
          //وقتی میخوایم مشخص کنیم table ما چه فیلد هایی داشته باشه
          return db.execute(
              'CREATE TABLE user_checks(id TEXT PRIMARY KEY, payTo TEXT, bankName TEXT, amount DOUBLE, date TEXT, time TEXT)');
        }, version: 1);
  }

  //برای اضافه کردن اطلاعات به دیتابیس از متد زیر استفاده میکنیم
  //این متد به عنوان پارامتر ورودی یک آبجکت از کلاس Note را دریافت و در دیتابیس ذخیره میکند.
  //مقدار result در متد آیدی منحصر به فرد اطلاعاتی میباشد که در دیتابیس ذخیره کردیم
  //در کلاس Check متدی داشتیم به نام toMap, این متد کار تبدیل آبجکت های کلاس به Map را انجام می دهد
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //متد get آبجکت های ورودی دیتابیس را برمیگرداند.
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
