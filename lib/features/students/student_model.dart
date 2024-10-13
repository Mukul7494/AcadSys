class Student {
  final String name;
  final int age;
  final String branch;
  final int rollno;
  final Function payment;

  Student(
      {required this.rollno,
      required this.payment,
      required this.name,
      required this.age,
      required this.branch});
}
