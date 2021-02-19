/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskteller/models/note.dart';
import 'package:taskteller/utils/database_helper.dart';
import 'package:taskteller/main_screens/note_details.dart';
import 'package:sqflite/sqflite.dart';


class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', '','', 2), 'Add Note');
        },

        tooltip: 'Add Note',

        child: Icon(Icons.add),

      ),
    );
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].title, style: titleStyle,),

            subtitle: Text(this.noteList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Note');
            },

          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


/*  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
*/

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

 */









import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskteller/main_screens/note_details.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:taskteller/models/note.dart';
import 'package:taskteller/utils/database_helper.dart';
class NoteList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return NoteListState();
  }

}

class NoteListState extends State<NoteList>{
  //
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  //
  int count =0;
  @override
  Widget build(BuildContext context) {
    if(noteList ==null){
      noteList =List<Note>();
      updateListView();

    }


    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),)
        ),
        title: Text("Task Teller"),
      ),

      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint("FAB debug print");
          navigateToDetail(Note('','',2),'Add Task');
        },
        tooltip:'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView(){
    // ignore: deprecated_member_use
    TextStyle textStyle=Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white70,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child:  ListTile(
              leading: CircleAvatar(
                //changing color from below developed function
                backgroundColor: getPriorityColor(this.noteList[position].priority),
                //changing icons based on priority[function developed below]
                child: getPriorityIcons(this.noteList[position].priority),
              ),
              //changing title
              title: Text(this.noteList[position].title, style: textStyle,),
              //changing date
              subtitle:  Text(this.noteList[position].date),
              //here wrapped this whole icon thing in gesture detector
              trailing: GestureDetector(
                child: Icon(Icons.delete,color: Colors.black,),
                onTap:(){
                  _deleteT(context, noteList[position]);
                } ,

              ),
              onTap:(){
                debugPrint("list tile debug print");
                //calling function to navigate on other screen
                navigateToDetail(this.noteList[position],'Edit Task');
              } ,



            ),

          );
      },
    );
  }
  //helper function
  //return priority colors
  Color getPriorityColor (int priority){
    switch (priority){
      case 1:
          return Colors.red;
          break;
      case 2:
        return Colors.blue;
        break;
      default:
        return Colors.red;
    }

  }
  //return priority icons
  Icon getPriorityIcons(int priority){
    switch(priority){
      case 1:
        return Icon(Icons.access_alarms);
        break;
      case 2:
        return Icon(Icons.alarm_on);
        break;
      default:
        return Icon(Icons.alarm_on);
    }

  }
  //delete task from main list
  void _deleteT(BuildContext context,Note note)async{
    int result =await databaseHelper.deleteNote(note.id);
    if(result !=0){
      _showSnackBar(context,'Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar=SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }




  void navigateToDetail(Note note,String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(note,title);
    }
    ));
    if(result== true){
      updateListView();


    }


  }
  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });

    });


  }
}

