import 'dart:io';

class Student {
  int? id;
  String? firstName;
  String? lastName;
  int? gradePoint;
  //String? _status;
  String? photoURL = "blankprofile.png";
  String? operation = "";
  File? photoFile;
//if you want delete or update a student the list use this
  Student.withId(int id, String firstName, String lastName, int gradePoint,
      String photoURL) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.gradePoint = gradePoint;
    this.photoURL = photoURL;
  }
//if you want add a student the list use this
  Student(String firstName, String lastName, int gradePoint, String photoURL) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.gradePoint = gradePoint;
    this.photoURL = photoURL;
  }
  Student.withOutInfo() {}
  String get getFirstName {
    return "STU -" + this.firstName!;
  }

  void set setFirstName(String value) {
    this.firstName = value;
  }

  String get getStatus {
    //read-only area
    String message = "";
    if (this.gradePoint == null) {
      message = "getStatus is null";
    } else {
      if (this.gradePoint! >= 50) {
        message = "Pass";
      } else if (this.gradePoint! >= 40) {
        message = "The makeup exam";
      } else {
        message = "Failed";
      }
    }
    return message;
  }
}
