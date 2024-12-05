import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/studentController.dart';
import 'package:flutter_application_1/models/student.dart';
import 'package:flutter_application_1/screens/student_add.dart';
import 'package:flutter_application_1/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  // State<MyApp> createState() {
  //   return _MyAppState();
  // }
}

class _MyAppState extends State<MyApp> {
  //const MyApp({super.key});
  String appBarMsg = "Students Management Page";
  Student selectedStudent = Student.withId(0, "", "", 0, "");
  Student lastOperationStu = Student.withId(0, "", "", 0, "");
  var studentController = StudentController();

  //data source
  List<Student> students = [
    Student.withId(1, "Arwen ", "Galadhrim", 5, "1.png"),
    Student.withId(2, "Galadriel", "Fëanorian", 10, "2.png"),
    Student.withId(3, "Thalion", "Bronzebirch", 15, "3.png"),
    Student.withId(4, "Lirael", "Silverleaf", 25, "4.png"),
    Student.withId(5, "Faramir", "Nightshadow", 40, "5.png"),
    Student.withId(6, "Elarion", "Stonehand", 35, "2.png"),
    Student.withId(7, "Nyssa", "Windrider", 70, "1.png"),
    Student.withId(8, "Caelum", "Fireforge", 50, "2.png"),
    Student.withId(9, "Tariel", "Duskwalker", 100, "3.png"),
    Student.withId(10, "Elenion", "Fireforge", 50, "2.png"),
    Student.withId(11, "Tariel", "Duskwalker", 100, "3.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(appBarMsg),
          backgroundColor: const Color.fromARGB(204, 216, 76, 5)),
      body: buildBody(context),
    );
  }

  void showAlert(BuildContext context, String title, String msg) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  //listviewin.builder listenin eleman sayısı kadar bu bloğu çalıştırır.
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: students[index].photoFile != null
                          ? Image.file(
                              students[index].photoFile!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "images/${students[index].photoURL.toString()}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                    ),
                    title: Text(students[index].firstName.toString() +
                        " " +
                        students[index].lastName.toString()),
                    subtitle: Text("GPA : " +
                        students[index].gradePoint.toString() +
                        "[${students[index].getStatus.toString()}]"),
                    trailing: buildStatusIcon(students[index].gradePoint),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                      // print(selectedStudent);
                    },
                  );
                })),
        Column(
          children: [
            Text("Last Operation - STU : ${lastOperationStu.operation} - " +
                lastOperationStu.firstName.toString() +
                " " +
                lastOperationStu.lastName.toString()),
            Container(
              margin: EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  Container(
                    child: GestureDetector(
                      child: Icon(Icons.clear),
                      onTap: () {
                        setState(() {
                          selectedStudent = Student.withId(0, "", "", 0, "");
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Selected STU : " +
                      selectedStudent.firstName.toString() +
                      " " +
                      selectedStudent.lastName.toString()),
                ],
              ),
            ),
          ],
        ),
        Row(
          //Add,update,delete buttons widget
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  //showAlert(context, "Added", "Added student: ");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAddScreen(students,
                                  onStudentAdded: (newStudent) {
                                setState(() {
                                  //update the list when a new student is added.
                                  lastOperationStu = newStudent;
                                });
                              })));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Add new",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0))),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedStudent.id != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentEditScreen(
                                  selectedStudent,
                                  onStudentEdited: (newStudent) {
                                    setState(() {
                                      //update the list when a edited student is edited.

                                      lastOperationStu = newStudent;
                                    });
                                  },
                                  onPhotoEdited: (newFile) {
                                    setState(() {
                                      selectedStudent.photoFile = newFile;
                                      selectedStudent =
                                          Student.withId(0, "", "", 0, "");
                                    });
                                  },
                                )));
                  } else {
                    showAlert(context, "Eror",
                        "Selected student is empty. Please select a student.");
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.update_rounded,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Update",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0))),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                    lastOperationStu = selectedStudent;
                  });

                  showAlert(context, "Deleted",
                      "Deleted Student: ${selectedStudent.firstName.toString() + " " + selectedStudent.lastName.toString()}");
                  lastOperationStu = selectedStudent;
                  studentController.stuDelete(selectedStudent);
                  selectedStudent = Student.withId(0, "", "", 0, "");
                  print(lastOperationStu.operation.toString());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0))),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int? gradePoint) {
    if (gradePoint == null) {
      return Icon(Icons.signal_cellular_null);
    } else {
      if (gradePoint >= 50) {
        return Icon(Icons.done);
      } else if (gradePoint >= 40) {
        return Icon(Icons.album);
      } else {}
      return Icon(Icons.clear);
    }
  }

  Future<void> checkFileExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      print("Dosya var: $path");
    } else {
      print("Dosya bulunamadı: $path");
    }
  }
}
