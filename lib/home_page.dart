import 'package:flutter/material.dart';
import 'package:sqflite_app/DataBase/sqf_lite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqfLiteDb sqfLiteDb = SqfLiteDb();

  Future<List<Map>> ireadData() async {
    List<Map> response = await sqfLiteDb.readData("SELECT * FROM 'notes' ");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 36, 8, 84),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: ireadData(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index]['title']),
                          subtitle: Text(snapshot.data![index]['note']),

                        ),
                      
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
