import 'package:flutter_application_1/models/student.dart';

class StudentController {
  void stuDelete(Student student) {
    student.operation = "Deleted";
  }

  void stuUpdate(Student student) {
    student.operation = "Updated";
  }

  void stuAdd(Student student) {
    student.operation = "Added";
  }
}
