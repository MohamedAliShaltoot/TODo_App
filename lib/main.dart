import 'package:flutter/material.dart';
import 'package:sqflite_app/add_note_screen.dart';
import 'package:sqflite_app/home_page.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:'/home' ,
     // home: const MyHomePage(),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/add_note': (context) => const AddNoteScreen(),},
    );
  }
}

