import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/functions/db_functions.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_db_sample/screen_home.dart';
import 'package:image_picker/image_picker.dart';

class ScreenAdd extends StatefulWidget {
  ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _batchController = TextEditingController();

  final _mobileController = TextEditingController();
  String? imagePath;

  Future<void> imagePick() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(224, 173, 221, 243),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Details'),
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
                        ? const AssetImage('assets/images/download.png')
                            as ImageProvider
                        : FileImage(File(imagePath!)),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: InkWell(
                      child: const Icon(Icons.add_a_photo),
                      onTap: () {
                        imagePick();
                      },
                    ),
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () => imagePick(),
              //   child: CircleAvatar(
              //     radius: 70,
              //     backgroundColor: Color.fromARGB(255, 28, 24, 24),
              //     child: ClipOval(
              //       child: SizedBox.fromSize(
              //         size: const Size.fromRadius(70),
              //         child: (image != null)
              //             ? Image.file(
              //                 image,
              //                 fit: BoxFit.cover,
              //               )
              //             : Image.asset('assets/images/download.png'),
              //       ),
              //     ),
              //   ),
              // ),

              // CircleAvatar(

              //   backgroundImage: imagePath == null
              //       ? const AssetImage('assets/images/download.png')
              //           as ImageProvider
              //       : FileImage(File(imagePath!)),
              //   radius: 50,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
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
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                    hintText: 'Batch name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(240, 236, 236, 0.771),
                    hintText: 'Mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
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
                    if (imagePath != null &&
                        _nameController.text.isNotEmpty &&
                        _ageController.text.isNotEmpty &&
                        _batchController.text.isNotEmpty &&
                        _mobileController.text.length == 10) {
                      onAddButonClicked();
                      studentAddSuccess();
                    } else {
                      validCheck();
                    }
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddButonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _batch = _batchController.text.trim();
    final _mobile = _mobileController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _mobile.isEmpty) {
      return;
    }
    // print('$_name');

    final _student = StudentModel(
        name: _name,
        age: _age,
        batch: _batch,
        mobile: _mobile,
        img: imagePath!);

    addStudent(_student);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return ScreenHome();
      },
    ));
    ScreenHome();
  }

  validCheck() {
    var _errorMessage = '';

    if (imagePath == null &&
        _nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _batchController.text.isEmpty &&
        _mobileController.text.isEmpty) {
      _errorMessage = 'Please fill all the fields';
    } else if (imagePath == null) {
      _errorMessage = 'Please add Image';
    } else if (_nameController.text.isEmpty) {
      _errorMessage = 'Please Fill name field';
    } else if (_ageController.text.isEmpty) {
      _errorMessage = 'Please fill age field';
    } else if (_batchController.text.isEmpty) {
      _errorMessage = 'Please fill Batch field';
    } else if (_mobileController.text.isEmpty ||
        _mobileController.text.length != 10) {
      _errorMessage = 'Enter valid mobile number';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        content: Text(_errorMessage)));
  }

  void studentAddSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 31, 46, 31),
        content: Text('Added Successfully!!')));
  }
}
