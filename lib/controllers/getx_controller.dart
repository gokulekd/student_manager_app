import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager_app/model/database/student_DB.dart';
import 'package:student_manager_app/views/home/homepage.dart';

class Studentcontroller extends GetxController {
  final nameController = TextEditingController();
  final batchController = TextEditingController();
  final domainController = TextEditingController();
  final markController = TextEditingController();
  final mobileController = TextEditingController();

  Box<student_DB> observableBox = Hive.box<student_DB>('Student_DB');
  int get boxCount => observableBox.length;
  File? image;
  String? imagepath ;

  var dropdowncontroll = '';

  updateDropdown(String value) async {
    dropdowncontroll = value;
    update();
  }

  deleteSelectedStudent(index) async {
    final observableBox = await Hive.openBox<student_DB>('Student_DB');

    observableBox.deleteAt(index);
    update();
  }

  deleteAllStudent() async {
    await observableBox.clear();
    log('delete aayiiiiiiiiiiiiiiiiiiiiiiiiii');

    update();
  }

  createStudent(StudentData) {
    // final observableBox = await Hive.openBox<student_DB>('Student_DB');

    observableBox.add(StudentData);
    log('create aayiiiiiiiiiiiiiiiiiiiiiiiiii');
    update();
    log(observableBox.values.length.toString());
  }

  fetchgalleryimage() async {
    final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Image == null) return;
    final ImageTemporory = File(Image.path);
    image = ImageTemporory;
     imagepath =image!.path;
    update();
    return image;
  }

  fetchCamaraImage() async {
    final Image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (Image == null) return;
    final ImageTemporory = File(Image.path);
    image = ImageTemporory;
    imagepath =image!.path;
    update();
    return image;
  }

  
}
