import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_db_sample/screen_home.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Details',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: ScreenHome(),
    );
  }
}
