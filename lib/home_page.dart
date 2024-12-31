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
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 8, 84),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          color: const Color.fromARGB(255, 36, 8, 84),
                          margin: const EdgeInsets.all(8),
                          elevation: 10,

                          child: ListTile(
                            title: Text(snapshot.data![index]['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(snapshot.data![index]['note'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  
                                });
                                sqfLiteDb.deleteData(
                                    "DELETE FROM 'notes' WHERE id = ${snapshot.data![index]['id']}");
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        backgroundColor: const Color.fromARGB(255, 36, 8, 84),
        onPressed: () {
          Navigator.pushNamed(context, '/add_note');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
