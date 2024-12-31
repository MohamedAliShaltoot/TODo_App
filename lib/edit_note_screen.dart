import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/DataBase/sqf_lite.dart';
import 'package:sqflite_app/home_page.dart';

class EditNoteScreen extends StatefulWidget {
  final String title;
  final String description;
  final int id;

  const EditNoteScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreen();
}

class _EditNoteScreen extends State<EditNoteScreen> {
  SqfLiteDb sqfLiteDb = SqfLiteDb();
  GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    noteController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
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
                  int response = await sqfLiteDb.updateData(
                      "UPDATE notes SET title = '${titleController.text}', note = '${noteController.text}' WHERE id = ${widget.id}");
                  if (kDebugMode) {
                    print(response);
                  }
                  if (response > 0) {
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Note edited successfully!")),
  );
  // ignore: use_build_context_synchronously
  Navigator.pushReplacementNamed(context, '/home');
}

                },
                child: const Text("Edit Note",
                    style: TextStyle(color: Colors.white)),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
