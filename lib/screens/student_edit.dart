import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/student.dart';
import 'package:flutter_application_1/validation/student_validator.dart';
import 'package:image_picker/image_picker.dart';

class StudentEditScreen extends StatefulWidget {
  final Function(Student) onStudentEdited;
  final Function(File) onPhotoEdited;
  Student? selectedStudent;
  StudentEditScreen(Student? selectedStudent,
      {required this.onStudentEdited, required this.onPhotoEdited}) {
    this.selectedStudent = selectedStudent;
  }

  @override
  State<StatefulWidget> createState() {
    return _StudentEditScreen(selectedStudent!);
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

class _StudentEditScreen extends State<StudentEditScreen>
    with stuValidationMixin {
  Student? selectedStudent;
  var formKey = GlobalKey<FormState>();

  _StudentEditScreen(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
  }
  File? selectedImg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Selected Student Edit"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          height: 650,
          margin: EdgeInsets.only(top: 20, left: 35.0, right: 35.0),
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
                  SizedBox(height: 10),
                  buildStudentImage(),
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
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      initialValue: selectedStudent?.firstName,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Gimli",
        border: OutlineInputBorder(),
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
        selectedStudent?.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent?.lastName,
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
        selectedStudent?.lastName = value;
      },
    );
  }

  Widget buildGradePointField() {
    return TextFormField(
      initialValue: selectedStudent?.gradePoint.toString(),
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
        selectedStudent?.gradePoint = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text("Submit"),
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          formKey.currentState!.save();
          selectedStudent?.operation = "Edited";
          selectedImg == null
              ? null
              : selectedStudent?.photoURL = selectedImg.toString();
          widget.onStudentEdited(selectedStudent!);
          widget.onPhotoEdited(selectedImg!);
          showAlert(context, "Edited",
              "Edited: ${selectedStudent!.firstName.toString() + " " + selectedStudent!.lastName.toString()}");
          //Navigator.pop(context);
        } else {
          return print("Validation is null");
        }
      },
    );
  }

  Widget buildStudentImage() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(100)),
          child: selectedImg != null
              ? Image.file(
                  selectedImg!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  "images/${selectedStudent?.photoURL.toString()}",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
        ),
        ElevatedButton(
            onPressed: () {
              pickImageFromGallery();
              print("Editted");
            },
            child: Row(
              children: [
                Text("Change your profile picture"),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.edit)
              ],
            )),
      ],
    );
  }

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = returnedImage.name;
      final targetPath = '${appDir.path}/$fileName';
      final targetFile = File(targetPath);

      if (!(await targetFile.parent.exists())) {
        await targetFile.parent.create(recursive: true);
      }

      final savedImage = await File(returnedImage.path).copy(targetPath);

      setState(() {
        selectedImg = savedImage;
        print("Dosya yolu" + selectedImg!.path);
      });
    }
  }
}
