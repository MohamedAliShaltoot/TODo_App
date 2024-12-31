import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/DataBase/sqf_lite.dart';
import 'package:sqflite_app/home_page.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  SqfLiteDb sqfLiteDb = SqfLiteDb();
  GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note", style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 36, 8, 84),
      ),
      body: ListView(children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 36, 8, 84),
                ),
                onPressed: () async {
                  int response = await sqfLiteDb.insertData(
                      "INSERT INTO 'notes' ('title', 'note') VALUES ('${titleController.text}', '${noteController.text}')");
                  if (kDebugMode) {
                    print(response);
                  }
                  if (response > 0) {
                    Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  }
                },
                child: const Text("Add Note",
                    style: TextStyle(color: Colors.white)),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
