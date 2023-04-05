import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final _id = await studentDB.add(value);
  value.id = _id;

  getAllStudents();
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();

for(var std in studentDB.values){
  studentListNotifier.value.add(std);
}
  // studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');

  await studentDb.delete(id);
  getAllStudents();
}
