import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskteller/models/note.dart';
import 'package:taskteller/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  NoteDetail(this. note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['High', 'Low'];

   //Instantiation
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //Constructor
  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();

        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First element
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String> (
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),

                      style: textStyle,

                      value: getPriorityAsString(note.priority),

                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('User selected $valueSelectedByUser');
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      }
                  ),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

               /* // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),*/

                /*4th element start*/
                //one
                Padding(
                  padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                  child: Row(
                    children:<Widget> [

                      ButtonTheme(
                        minWidth: 20,
                        height: 50,

                        child:Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text('Add', textScaleFactor:1.5,
                            ),
                            onPressed: (){
                              setState(() {
                                debugPrint('4th element add button');
                                _save();
                              });
                            },
                          ),
                        ),
                      ),

                      Container(width: 5.0,),


                      //two
                      ButtonTheme(
                        minWidth: 20,
                        height: 50,
                        child:Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text('Delete', textScaleFactor:1.5,
                            ),
                            onPressed: (){
                              setState(() {
                                debugPrint('4th element delete button');
                                _delete();
                              });
                            },
                          ),
                        ),),

                      /*4th element end*/

                    ],
                  ),
                ),

              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];  // 'High'
        break;
      case 2:
        priority = _priorities[1];  // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(note);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Task Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Task');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Task was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Tash Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
      //builder: (BuildContext context){
          //return alertDialog;
      //}
    );
  }

}













/*
//import 'dart:async';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskteller/models/note.dart';
import 'package:taskteller/utils/database_helper.dart';

class NoteDetail extends StatefulWidget{
  final String appBarTitle;
  final Note note;
  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState(this.note, this.appBarTitle);
  }

}

class NoteDetailsState extends State<NoteDetail>{
   final Note note;
  // for task priority
  static var _hl=['High','Low'];
  DatabaseHelper helper=  DatabaseHelper();

  String appBarTitle;
  TextEditingController titleController=TextEditingController();
  TextEditingController editingController=TextEditingController();

  NoteDetailsState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    //textstyle we have used below..
    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    editingController.text= note.description;

    // TODO: implement build;
    return WillPopScope(
      onWillPop:(){
        moveBack();
      },
      child:Scaffold(
      appBar:  AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon:  Icon(
          Icons.arrow_back
        ),
          onPressed: (){
          moveBack();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
        child: ListView(
            children: <Widget>[
              /* 1st element start*/
          ListTile(
            title: DropdownButton(
              items:_hl.map((String dropDownStringItem){
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }
              ).toList(),

              style: textStyle,
              value: 'Low',

              onChanged: (_valueSelectedByUser){
                setState(() {
                  debugPrint('User Selected $_valueSelectedByUser');
                  updatePriorityAsInt(_valueSelectedByUser);
                });

              },
            ),
          ),

              /* 1st element end*/
              /* 2nd element start*/
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value){
                    debugPrint('Something changed in title');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                ),
              ),
              /* 2nd element end*/

              /* 3rd element end*/
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: TextField(
                  controller: editingController,
                  style: textStyle,
                  onChanged: (value){
                    debugPrint('Something changed in Description');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                  /**/  border: OutlineInputBorder( /**/
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                ),
              ),
              /* 3rd element end*/

              /*4th element start*/
              //one
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: Row(
                  children:<Widget> [

                  ButtonTheme(
                    minWidth: 20,
                    height: 50,

                    child:Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Add', textScaleFactor:1.5,
                        ),
                        onPressed: (){
                          setState(() {
                            debugPrint('4th element add button');
                            _save();
                          });
                        },
                      ),
                    ),
                  ),

                Container(width: 5.0,),


                //two
                    ButtonTheme(
                      minWidth: 20,
                      height: 50,
                      child:Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Delete', textScaleFactor:1.5,
                        ),
                        onPressed: (){
                          setState(() {
                            debugPrint('4th element delete button');
                            _delete();
                          });
                        },
                      ),
                    ),),

                    /*4th element end*/

                  ],
                ),
              ),
              /*4th element end*/

            ]
        ),

      ),
    ),
    );

  }
  //pop is used to go back on last screen..
  // *not exactly but yes it work like that*
  void moveBack(){
    Navigator.pop(context);

  }
   // Convert the String priority in the form of integer before saving it to Database
   void updatePriorityAsInt(String value){
    switch(value){
      case 'High':
        note.priority=1;
        break;
      case'Low':
        note.priority=2;
        break;
    }

   }

   // Convert int priority to String priority and display it to user in DropDown
String getPriorityAsString(int value){
    String priority;
    switch(value){
      case 1:
        priority = _hl[0]; //high priority H
        break;
      case 1:
        priority = _hl[0]; //low priority l
        break;
    }
    return priority;
}
// Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = editingController.text;
  }
  // save to database title
void _save() async{
    moveBack();
    note.date= DateFormat.yMMMd().format(DateTime.now());

    int result;
    if(note.id !=null){
      result = await helper.updateNote(note);
    }
    else{
      result = await helper.insertNote(note);

    }
    if(result !=0){
      _showAlertDialog('Status','Task Saved');
    }
    else{
      _showAlertDialog('Status','Problem in saving');

    }
}
  void _delete() async {

    moveBack();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(title: Text(title),
    content: Text(message),
    );
    showDialog(context: context,
    builder: (_)=> alertDialog);
  }


}

 */

