import 'package:flutter/material.dart';
import 'package:taskteller/main_screens/note_list.dart';
//import 'package:taskteller/main_screens/note_details.dart';

void main() {
  runApp(MyApp());
}
 class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Teller Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: NoteList(),
    );
  }
}
