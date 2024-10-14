import 'package:flutter/material.dart';
import 'student_model.dart'; // Ensure this imports your Student model

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  // List of students with their details and payment function
  final List<Student> students = [
    Student(
      name: 'John Doe',
      age: 20,
      branch: 'Computer Science',
      rollno: 1,
      payment: () => print("Payment made for John Doe"),
    ),
    Student(
      name: 'Jane Smith',
      age: 22,
      branch: 'Mathematics',
      rollno: 2,
      payment: () => print("Payment made for Jane Smith"),
    ),
    Student(
      name: 'Michael Johnson',
      age: 21,
      branch: 'Physics',
      rollno: 3,
      payment: () => print("Payment made for Michael Johnson"),
    ),
    Student(
      name: 'Emily Davis',
      age: 19,
      branch: 'Chemistry',
      rollno: 4,
      payment: () => print("Payment made for Emily Davis"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(student.name[0]),
              ),
              title: Text(student.name),
              subtitle: Text(
                  'Age: ${student.age}, Branch: ${student.branch}, Roll No: ${student.rollno}'),
              trailing: ElevatedButton(
                onPressed: () {
                  student.payment();
                },
                child: const Text('Pay'),
              ),
            ),
          );
        },
      ),
    );
  }
}
