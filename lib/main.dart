// import 'package:flutter/material.dart';
// import 'package:sqflite_app/add_note_screen.dart';
// import 'package:sqflite_app/home_page.dart';

// void main() {
//   runApp(const NoteApp());
// }

// class NoteApp extends StatelessWidget {
//   const NoteApp({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
       
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute:'/home' ,
//      // home: const MyHomePage(),
//       routes: {
//         '/home': (context) => const MyHomePage(),
//         '/add_note': (context) => const AddNoteScreen(),},
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sqflite_app/add_note_screen.dart';
import 'package:sqflite_app/home_page.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      initialRoute: '/home',
      routes: {
        '/home': (context) => MyHomePage(toggleTheme: toggleTheme),
        '/add_note': (context) => const AddNoteScreen(),
      },
    );
  }
}
