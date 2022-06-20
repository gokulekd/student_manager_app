


import 'package:hive/hive.dart';
part 'student_DB.g.dart';

@HiveType(typeId: 1)
class student_DB {
  student_DB(
      {required this.name,
      required this.batch,
      required this.domain,
      required this.mark,
      required this.mobile,
      this.imagepath
      });

      
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String batch;
  @HiveField(2)
  final String domain;
  @HiveField(3)
  final String mark;
  @HiveField(4)
  final String mobile;
  @HiveField(5)
   final String? imagepath;
}
