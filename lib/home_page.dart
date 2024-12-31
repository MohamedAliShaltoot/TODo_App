// import 'package:flutter/material.dart';
// import 'package:sqflite_app/DataBase/sqf_lite.dart';
// import 'package:sqflite_app/edit_note_screen.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Map> notes = [];
//   SqfLiteDb sqfLiteDb = SqfLiteDb();
//   bool isLoading = true;

//   rreadData() async {
//     List<Map> response = await sqfLiteDb.readData("SELECT * FROM 'notes' ");
//     notes.addAll(response);
//     isLoading = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     rreadData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Notes",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(255, 36, 8, 84),
//       ),
//       body: isLoading
//           ? const Center(
//               child: Center(
//                   child: Text(
//               "Loading...",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 158, 15, 15)),
//             )))
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: notes.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         color: const Color.fromARGB(255, 36, 8, 84),
//                         margin: const EdgeInsets.all(8),
//                         elevation: 10,
//                         child: ListTile(
//                           title: Text(notes[index]['title'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           subtitle: Text(notes[index]['note'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700,
//                               )),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () async {
//                                   int response = await sqfLiteDb.deleteData(
//                                       "DELETE FROM 'notes' WHERE id = ${notes[index]['id']}");

//                                   if (response > 0) {
//                                     notes.removeWhere((element) =>
//                                         element['id'] == notes[index]['id']);
//                                     setState(() {});
//                                   }
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.edit,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => EditNoteScreen(
//                                           id: notes[index]['id'],
//                                           title: notes[index]['title'],
//                                           description: notes[index]['note'],
//                                         ),
//                                       ));
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: "Add Note",
//         backgroundColor: const Color.fromARGB(255, 36, 8, 84),
//         onPressed: () {
//           Navigator.pushNamed(context, '/add_note');
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 25,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:sqflite_app/DataBase/sqf_lite.dart';
import 'package:sqflite_app/edit_note_screen.dart';

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const MyHomePage({super.key, required this.toggleTheme});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> notes = [];
  SqfLiteDb sqfLiteDb = SqfLiteDb();
  bool isLoading = true;

  rreadData() async {
    List<Map> response = await sqfLiteDb.readData("SELECT * FROM 'notes' ");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    rreadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notes.isEmpty
              ? const Center(
                  child: Text("No notes available. Add some!"),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(notes[index]['title']),
                        subtitle: Text(notes[index]['note']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNoteScreen(
                                      id: notes[index]['id'],
                                      title: notes[index]['title'],
                                      description: notes[index]['note'],
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                int response = await sqfLiteDb.deleteData(
                                    "DELETE FROM 'notes' WHERE id = ${notes[index]['id']}");
                                if (response > 0) {
                                  setState(() {
                                    notes.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
