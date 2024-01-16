// ignore_for_file: unused_import, avoid_print
import 'dart:ffi';

import 'package:sqflite/sqflite.dart'; // تحتوي على ال join
//ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initdb();
      // ignore: recursive_getters
      return _db; // فهمتي وين الايرور كاين ؟
    } else {
      // ignore: recursive_getters
      return _db;
    }
  }

  initdb() async {
    String databasepath =
        await getDatabasesPath(); // مسار وموقع الداتا بيس افتراضي من عنده
    String path = join(databasepath,
        'shaden.db'); //  اسم الداتا بيس ونربطه بمسار الداتا بيس حتى يكون حاهز لفينكشن الداتا بيس
    // join used to create path like databasepath/shaden.db
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    // onCreate: بتم استدعاها مرة واحدة فقط وهي عند انشاء الداتا بيس فأي اضافة جدول اخر ما رح يتم انشاؤه والحل هو تغييرversion , onUpgrade
    return mydb;
  }

//onUpgrade: يتم استدعائها عندما يتغير الفيرجين يعني عتدما يتم تغيير على الداتا بيس
  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade================");
  }

// onCreate used to create tabels.
  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "notes"(
"id" INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL ,
"note" TEXT NOT NULL
)
    ''');
    print("CREATE DATABASE");
  }

  // ما دام الفنكشن future لازم await
  // الفنكشن مشان select
  readData(String sql) async {
    // هون عند باريميتر مش معرف
    Database? mydb = await db; // لا
    List<Map> response = await mydb!.rawQuery(sql); // rawQuery خصاة بالسليكت
    // ! بحكيله على ضمانتي انها مش null لانه ان اكنت حاطة علامة الاسنفهام الى بدل على الnull

    return response;
  }

  insertData(String sql) async {
    print(sql);
    Database? mydb = await db;
    if (mydb == null) {
      print("NULL DBBBBB ");
    } else {
      print(".............");
    }
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deletData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

//  mydeleteDatabse() {}
  // int: لانهم برجعوا كم سطر نحذف او كم سطر تم اضافته ووووو

  mydeleteDatabse() async {
    String databasepath =
        await getDatabasesPath(); // مسار وموقع الداتا بيس افتراضي من عنده
    String path = join(databasepath, 'shaden.db');
    await deleteDatabase(path);
  }
}
