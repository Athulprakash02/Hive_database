import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String img;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String age;

  @HiveField(4)
  final String batch;

  @HiveField(5)
  final String mobile;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.batch,
    required this.mobile,
    required this.img,
  });
}
