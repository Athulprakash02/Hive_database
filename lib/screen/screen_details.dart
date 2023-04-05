import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/functions/db_functions.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_db_sample/screen/screen_person.dart';
import 'package:hive_db_sample/screen/screen_search.dart';
import 'package:hive_db_sample/screen/screen_update.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({super.key});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  late Box<StudentModel> studentBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentBox = Hive.box('student_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Student Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return PersonScreen(passValue: data, idPass: index);
                      },
                    ));
                  },

                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: FileImage(File(data.img)),
                  ),
                  title: Text(data.name),

                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateScreen(index: index),
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteAlert(context, data.key);
                            //  if(data.id != null){

                            //    deleteStudent(data.id!);
                            //  }else{
                            //   print('key not found');
                            //  }
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  // IconButton(onPressed: () {

                  //     }, icon: Icon(Icons.delete)),
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: studentList.length,
            );
          },
        ),
      ),
    );
  }

  deleteAlert(BuildContext context, key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
          'Delete data Permanently?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () {
                deleteStudent(key);
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red, fontSize: 20),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 76, 228, 15), fontSize: 20),
              ))
        ],
      ),
    );
  }
}
