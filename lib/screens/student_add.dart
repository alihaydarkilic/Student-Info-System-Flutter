import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/student.dart';
import 'package:flutter_application_1/validation/student_validator.dart';

class StudentAddScreen extends StatefulWidget {
  final Function(Student) onStudentAdded;
  List<Student>? students;

  StudentAddScreen(List<Student> students, {required this.onStudentAdded}) {
    this.students = students;
  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students!);
  }
}

void showAlert(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ),
        ],
      );
    },
  );
}

class _StudentAddState extends State<StudentAddScreen> with stuValidationMixin {
  List<Student>? students;
  var student = Student.withOutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(List<Student> students) {
    this.students = students;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("New Student Add"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            height: 400,
            margin: EdgeInsets.only(left: 35.0, right: 35.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(218, 255, 255, 255),
                border: Border.all(color: Colors.black, width: 0.0),
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(1, 5),
                  ),
                ]),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    buildFirstNameField(),
                    SizedBox(height: 30),
                    buildLastNameField(),
                    SizedBox(height: 30),
                    buildGradePointField(),
                    SizedBox(height: 30),
                    buildSubmitButton(),
                  ],
                )),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Gimli",
        border: OutlineInputBorder(), // Sınır için OutlineInputBorder kullan
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: TextStyle(fontSize: 18.0),
      validator: validateFirstName,
      onSaved: (value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Last Name", hintText: "Gloriel",
        border: OutlineInputBorder(), // Sınır için OutlineInputBorder kullan
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: TextStyle(fontSize: 18.0),
      validator: validateLastName,
      onSaved: (value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradePointField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Grade Point", hintText: "75",
        border: OutlineInputBorder(), // Sınır için OutlineInputBorder kullan
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: TextStyle(fontSize: 18.0),
      validator: validateGradePoint,
      onSaved: (value) {
        student.gradePoint = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text("Submit"),
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          formKey.currentState!.save();
          student.operation = "Added";
          students!.add(student);
          widget.onStudentAdded(student);
          showAlert(context, "Added",
              "Added: ${student.firstName.toString() + " " + student.lastName.toString()}");
          //Navigator.pop(context);
        } else {
          return print("Validation is null");
        }
      },
    );
  }
}
