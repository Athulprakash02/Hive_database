import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/functions/db_functions.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_db_sample/screen_home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  const UpdateScreen({super.key, required this.index});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _mobileController;
  late TextEditingController _batchController;

  int id = 0;
  String? name;
  int age = 0;
  String? imagePath;

  late Box<StudentModel> studentBox;
  late StudentModel student;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    studentBox = Hive.box('student_db');

    _idController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _batchController = TextEditingController();
    _mobileController = TextEditingController();

    student = studentBox.getAt(widget.index) as StudentModel;

    _idController.text = student.id.toString();
    _nameController.text = student.name.toString();
    _ageController.text = student.age.toString();
    _batchController.text = student.batch.toString();
    _mobileController.text = student.mobile.toString();
  }

  Future<void> updateButton(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _batch = _batchController.text.trim();
    final _mobile = _mobileController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _mobile.isEmpty) {
      return;
    }
    // print('$_name $_age $_batch $_mobile');

    final _students = StudentModel(
      name: _name,
      age: _age,
      batch: _batch,
      mobile: _mobile,
      img: imagePath ?? student.img,
    );

    final studentDB = await Hive.openBox<StudentModel>('student_db');

    studentDB.putAt(index, _students);
    getAllStudents();
  }

  Future<void> imagePick() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(236, 172, 218, 239),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Data'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: imagePath == null
                      ? FileImage(File(student.img))
                      : FileImage(File(imagePath ?? student.img)),
                ),
                Positioned(
                    right: 5,
                    bottom: 10,
                    child: InkWell(
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 30,
                      ),
                      onTap: () {
                        imagePick();
                      },
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                autofocus: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: student.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _ageController,
                autofocus: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: student.age,
                ),
                keyboardType: TextInputType.number,
                maxLength: 2,
                buildCounter: (BuildContext context,
                        {required int currentLength,
                        int? maxLength = 2,
                        bool? isFocused}) =>
                    null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _batchController,
                autofocus: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: student.batch,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _mobileController,
                autofocus: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: student.mobile),
                keyboardType: TextInputType.number,
                maxLength: 10,
                buildCounter: (BuildContext context,
                        {required int currentLength,
                        int? maxLength = 10,
                        bool? isFocused}) =>
                    null,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                updateButton(widget.index);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx) => ScreenHome(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.update_outlined),
              label: const Text('Update'),
            ),
          ],
        ),
      )),
    );
  }
}
