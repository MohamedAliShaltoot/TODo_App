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

Database mydb = await openDatabase(path, version: 1, onCreate:_onCreate) ;
return mydb;


   }

_onCreate(Database db, int version) async {

  await db.execute('''

  CREATE TABLE notes (id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT, title  NOT NULL TEXT, note NOT NULL TEXT)


  ''');
if (kDebugMode) {
  print('created');
}
   }


 }