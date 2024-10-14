import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class StudentDb {
  //here a private constructor is used to prevent instantiation of the class
  StudentDb._();

  static final StudentDb dbInstance = StudentDb._();
  static const tableName = 'students';
  static const rollNumberCol = 'roll_number';
  static const firstNameCol = 'first_name';
  static const lastNameCol = 'last_name';
  static const phoneNumberCol = 'phone_number';
  static const courseCol = 'course';
  static const classNameCol = 'class_name';

  Database? database;

  Future<Database> getStudentDatabase() async {
    if (database != null) {
      return database!;
    } else {
      database = await openDb();
      return database!;
    }
  }

  Future<Database> openDb() async {
    //here we get the path of the document directory in the device
    try {
      final Directory appPath = await getApplicationDocumentsDirectory();
      //here we join the paths of the document directory and the database com.example.student.db like this
      final String dbPath = join(appPath.path, 'student.db');

      final Database db =
          await openDatabase(dbPath, version: 1, onCreate: (db, version) {
        //here we create the table in the database
        db.execute(
            'CREATE TABLE $tableName ($rollNumberCol TEXT PRIMARY KEY, $firstNameCol TEXT, $lastNameCol TEXT, $phoneNumberCol TEXT, $courseCol TEXT, $classNameCol TEXT)');
      });

      return db;
    } on DatabaseException catch (e) {
      print(e.toString());
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //this function is used for adding a Students to the database
  Future<bool> addStudent(
      {required String rollNumber,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String course,
      required String className}) async {
    final Database db = await getStudentDatabase();

    //here this function will return rows affected by the query

    int rowsEffected = await db.insert(tableName, {
      rollNumberCol: rollNumber,
      firstNameCol: firstName,
      lastNameCol: lastName,
      phoneNumberCol: phoneNumberCol,
      courseCol: course,
      classNameCol: className
    });

    //this will check if any row effected or not
    return rowsEffected > 0;
  }

  //this function is used for getting all the students from the database
  Future<List<Map<String, dynamic>>> getStudents() async {
    final Database db = await getStudentDatabase();

    try {
      //this is same as select * from tableName
      final List<Map<String, dynamic>> students = await db.query(tableName);
      print(students);
      return students;
    } on DatabaseException catch (e) {
      print(e.toString());
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }

    //this is same as select * from tableName
  }

  //this function is used for deleting a student from the database
  Future<bool> deleteStudent(String rollNumber) async {
    final Database db = await getStudentDatabase();
    int rowsEffected = await db.delete(tableName,
        where: '$rollNumberCol = ?', whereArgs: [rollNumber]);
    return rowsEffected > 0;
  }

  //this function is used for updating a student in the database
  Future<bool> updateStudent(
      {required String rollNumber,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String course,
      required String className}) async {
    final Database db = await getStudentDatabase();
    int rowsEffected = await db.update(
        tableName,
        {
          rollNumberCol: rollNumber,
          firstNameCol: firstName,
          lastNameCol: lastName,
          phoneNumberCol: phoneNumber,
          courseCol: course,
          classNameCol: className
        },
        where: '$rollNumberCol = ?',
        whereArgs: [rollNumber]);
    return rowsEffected > 0;
  }
}
