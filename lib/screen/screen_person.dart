import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/model/data_model.dart';

class PersonScreen extends StatelessWidget {
  final double bgHeight = 240;
  final double profilePicHeight = 180;

  PersonScreen({
    Key? key,
    required this.passValue,
    required this.idPass,
  }) : super(key: key);

  StudentModel passValue;
  final int idPass;

  Widget content() {
    return Container(
      width: 240,
      //  height: 120,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 10, 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                '${passValue.name}',
                style: const TextStyle(
                  fontSize: 32,
                ),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                child: Row(
                  children: [
                    Text(
                      'Age: ',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${passValue.age}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(174, 32, 38, 121)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Batch: ',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${passValue.batch}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(174, 32, 38, 121)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Contact Number: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${passValue.mobile}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(174, 32, 38, 121)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget top() {
    final top = bgHeight - profilePicHeight / 2;
    final bottom = profilePicHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: bg(),
        ),
        Positioned(top: top, left: 100, child: profilePic())
      ],
    );
  }

  Widget bg() {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 1.3,
              colors: [
                Color.fromARGB(255, 45, 154, 244),
                Color.fromARGB(255, 47, 65, 67)
              ],
              center: Alignment.bottomCenter)),

      // color: Color.fromARGB(255, 184, 162, 99),

      width: double.infinity,
      height: bgHeight,
    );
  }

  Widget profilePic() {
    return CircleAvatar(
      radius: profilePicHeight / 2 + 3,
      child: CircleAvatar(
        backgroundImage: FileImage(File(passValue.img)),
        radius: profilePicHeight / 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 184, 214, 239),
        appBar: AppBar(
          title: (Text('Student Data')),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              top(),
              content(),
            ],
          ),
        ));
  }
}
