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


  _onUpgrade(Database db, int oldversion, int newversion) async 
  {
//    await db.execute('''
//  ALTER TABLE "notes" ADD COLUMN "note" TEXT NOT NULL
//   )
//   '''
//    );
  }






_onCreate(Database db, int version) async {  // will call for first time only

  await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
''');
if (kDebugMode) {
  print('created');
}
   }

 readData( String sql) async {
  Database? mydb = await db;  // wait the database to create
  List<Map> response = await mydb.rawQuery(sql);   //{id: 8, title: first app, note: it wasn ot easy bro}, {id: 8, title: first app, note: it wasn ot easy bro}, 
  return response;
 }


insertData( String sql) async {
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