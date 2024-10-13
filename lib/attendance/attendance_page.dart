import 'package:acadsys/attendance/student_attendance_card.dart';
import 'package:acadsys/utils/cutom_appbar.dart';
import 'package:acadsys/utils/full_space_button.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    const double bottomRadius = 30;
    const TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const MyCustomAppBar(title: 'Attendance Page'),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(47, 33, 149, 243),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(64, 158, 158, 158),
                    width: 1,
                  ),
                ),
                child: const Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Name',
                      style: textStyle,
                      // textScaler: const TextScaler.linear(1),
                    ),
                    Text(
                      'Roll No',
                      style: textStyle,
                      // textScaler: const TextScaler.linear(1),
                    ),
                    Text(
                      'Status',
                      style: textStyle,
                      // textScaler: const TextScaler.linear(1),
                    ),
                  ],
                ),
              ),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const AttendanceStudentCard(),
              const SizedBox(height: 65),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FullSpaceButton(
              onPressed: () {},
            )),
      ]),
    );
  }
}
