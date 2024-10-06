class Student {
  String? firstName;
  String? lastName;
  int? gradePoint;
  String? status;
  String? photoURL;

  Student(String firstName, String lastName, int gradePoint, String photoURL) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.gradePoint = gradePoint;
    this.status = "Geçti";
    this.photoURL = photoURL;
  }
}
