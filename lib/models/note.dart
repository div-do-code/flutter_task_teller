class Note {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}


/*
when we use restfulAPI we encode data in json with these Map's.
Learned from Woo+flutter app todayy date - 1 march 2021.
*/






/*
//this class will help in represent

//our database table
/*
*                  Notes table[notes.db]
*
*        |id    |title  |description|Priority|date|
*        |      |       |           |        |    |
*        |      |       |           |        |    |
*        |      |       |           |        |    |
*
*
* */

class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  //making constructor...i have used something like this in java
  Note(this._title,this._description,this._date,this._priority);

  //this is a named constructor of dart..through this
  //we can user same name constructor 2 times
  Note.withID(this._id,this._title,this._description,this._date,this._priority);

  //now making getters
      int get id => _id;
      String get title=> _title;
      String get description =>_description;
      String get date=>_date;
      int get priority=>_priority;
    //now making setters...some thing like java db connection class.
      set title(String newTitle) {
        if (newTitle.length <= 300 && newTitle == '') {
          this._title = newTitle;
        }
      }
      set description(String newDescription) {
        if (newDescription.length <= 300) {
        this._description = newDescription;
      }
         }
        set priority(int newPriority) {
          if (newPriority>=1 &&newPriority<=2) {
            this._priority = newPriority;
            }
          }
        set date(String newDate) {
          this._date = newDate;
          }

          /*
         //\\ converting note class object into a Map object//\\
          because [SQF_LITE] plugin deals in only Map objects
          so,we have to create Map objects to save in database
          and to retrieve from database
         */
          //that dynamic keyword is working for both String and int values
          //in this situation dynamic is = int,String both.
          Map<String, dynamic> toMap(){
            var map=Map<String,dynamic>();

            if(id !=null){
              map['id']=_id;
            }
            map['title']=_title;
            map['description']=_description;
            map['priority']=_priority;
            map['date']=_date;
            return map;

          }

          //\\ extracting note class object from  Map object//\\
          //this is again a named constructor.
          Note.fromMapObject(Map<String, dynamic> map){
            this._id = map['id'];
            this._title = map['title'];
            this._description = map['description'];
            this._priority = map['priority'];
            this._date = map['date'];


          }
}

 */


