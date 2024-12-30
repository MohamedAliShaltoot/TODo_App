import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
class SqfLiteDb
 {

 static Database? _db;

Future<Database> get db async{

if (_db != null) {
  return _db!;
}
_db = await initDb();
return _db!;
} 




initDb() async
   {

 String dataBasepath = await getDatabasesPath();

 String path = join(dataBasepath,'mohamed.db');  //------>dataBasepath/mohamed.db

Database mydb = await openDatabase(path, version: 1, onCreate:_onCreate,onUpgrade: _onUpgrade); 
return mydb;


   }


  _onUpgrade(Database db, int newversion, int oldversion) async 
  {

  }






_onCreate(Database db, int version) async {  // will call for first time only

  await db.execute('''

  CREATE TABLE notes (id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT, title  NOT NULL TEXT, note NOT NULL TEXT)


  ''');
if (kDebugMode) {
  print('created');
}
   }

 readData( String sql) async {
  Database? mydb = await db;  // wait the database to create
  List<Map> response = await mydb.rawQuery(sql);
  return response;
 }


isertData( String sql) async {
  Database? mydb = await db;  // wait the database to create
  int response = await mydb.rawInsert(sql); // 0 or 1,2,3...
  return response;
 }


 updateData( String sql) async {
  Database? mydb = await db;  // wait the database to create
  int response = await mydb.rawUpdate(sql);
  return response;
 }


 deleteData( String sql) async {
  Database? mydb = await db;  // wait the database to create
  int response = await mydb.rawDelete(sql);
  return response;
 }
















 }