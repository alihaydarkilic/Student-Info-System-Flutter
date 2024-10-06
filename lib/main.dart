import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  String mesaj = "Öğrenci takip sistemi!!!";
  List<Student> students = [
    Student("Arwen ", "Galadhrim", 5, "1.png"),
    Student("Elenion", "Fëanorian", 10, "2.png"),
    Student("Thalion", "Bronzebirch", 15, "3.png"),
    Student("Lirael", "Silverleaf", 25, "4.png"),
    Student("Faramir", "Nightshadow", 40, "5.png"),
    Student("Elarion", "Stonehand", 35, "5.png"),
    Student("Nyssa", "Windrider", 70, "1.png"),
    Student("Caelum", "Fireforge", 50, "2.png"),
    Student("Tariel", "Duskwalker", 100, "3.png"),
  ];

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(mesaj),
          backgroundColor: const Color.fromRGBO(0, 0, 155, 0.5)),
      body: buildBody(context),
    );
  }

  void showAlert(BuildContext context, String msg) {
    var alert = AlertDialog(
      title: Text("Results is showed"),
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
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/${students[index].photoURL.toString()}'),
                    ),
                    title: Text(students[index].firstName.toString() +
                        " " +
                        students[index].lastName.toString()),
                    subtitle: Text("Not ortalalaması : " +
                        students[index].gradePoint.toString()),
                    trailing: buildStatusIcon(students[index].gradePoint),
                    onTap: () {
                      print(students[index].firstName.toString());
                    },
                  );
                })),
        Center(
          child: ElevatedButton(
            onPressed: () {
              var msg = "Alert";
              showAlert(context, msg);
            },
            child: Text("Show result!!"),
          ),
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

  Widget buildStatusAvatar(int? gradePoint) {
    if (gradePoint == null) {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
      );
    } else {
      if (gradePoint >= 50) {
        return CircleAvatar(
          backgroundColor: Colors.green,
        );
      } else if (gradePoint >= 40) {
        return CircleAvatar(
          backgroundColor: Colors.yellow,
        );
      } else {}
      return CircleAvatar(
        backgroundColor: Colors.red,
      );
    }
  }
}
