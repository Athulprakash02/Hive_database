import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/model/data_model.dart';
import 'package:hive_db_sample/screen/screen_person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentDetails = List<StudentModel>.from(studentList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 101, 163, 214)),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      clearText();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 215, 209, 191),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Search',
                ),
                onChanged: (value) {
                  _studentSearch(value);
                },
              ),
              Expanded(
                  child: studentDetails.isNotEmpty
                      ? ListView.builder(
                          itemCount: studentDetails.length,
                          itemBuilder: (context, index) {
                            File imge = File(studentDetails[index].img);
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(imge),
                              ),
                              title: Text(studentDetails[index].name),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PersonScreen(
                                      passValue: studentDetails[index],
                                      idPass: index),
                                ));
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "Couldn't find results",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ))
            ],
          ),
        )),
      ),
    );
  }

  void _studentSearch(String value) {
    setState(() {
      studentDetails = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _searchController.clear();
//     List<StudentModel> studentLis =
//       Hive.box<StudentModel>('student_db').values.toList();
// List<StudentModel> studentDetail = List<StudentModel>.from(studentLis);
  }
}
