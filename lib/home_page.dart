import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/DataBase/sqf_lite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqfLiteDb sqfLiteDb = SqfLiteDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          TextButton(onPressed: () async {
         int id =   await sqfLiteDb.insertData("INSERT INTO notes ('title','note') VALUES ('first app','it wasn ot easy bro')");
            if (kDebugMode) {
              print(id);
            }
          }, child: const Text("Inset Data")),
          const SizedBox(
            height: 20,
          ),
          TextButton(onPressed: () async {
           List<Map> response = await sqfLiteDb.readData("SELECT * FROM 'notes' ");
            if (kDebugMode) {
              print(response);
            }
          }, child: const Text("Read Data")),
           const SizedBox(
            height: 20,
          ),
          TextButton(onPressed: () async {
          int response = await sqfLiteDb.deleteData("DELETE FROM 'notes' WHERE id = 1  ");
            if (kDebugMode) {
              print(response);
            }
          }, child: const Text("delete Data")),
           const SizedBox(
            height: 20,
          ),
          TextButton(onPressed: () async {
           int response = await sqfLiteDb.updateData("UPDATE 'notes' SET title = 'new title', note = 'new note' WHERE id = 2  ");
            if (kDebugMode) {
              print(response);
            }
          }, child: const Text("update Data")),
        ],
      ),
    );
  }
}
