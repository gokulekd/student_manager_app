import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager_app/controllers/getx_controller.dart';
import 'package:student_manager_app/model/database/student_DB.dart';
import 'package:student_manager_app/views/content/screen_data_base.dart';

import '../../views/home/homepage.dart';

class ScreeneEditStudent extends StatelessWidget {
  final int index;
  final Studentcontroller controller1 = Get.put(Studentcontroller()); //
  ScreeneEditStudent({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<student_DB> studentList = controller1.observableBox.values.toList();

    final nameController = TextEditingController(text: studentList[index].name);
    final batchController =
        TextEditingController(text: studentList[index].batch);
    final domainController =
        TextEditingController(text: studentList[index].domain);
    final markController = TextEditingController(text: studentList[index].mark);
    final mobileController =
        TextEditingController(text: studentList[index].mobile);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Student Data"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetBuilder<Studentcontroller>(builder: (_) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(80)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.file(
                        File(
                          controller1.imagepath ??
                              studentList[index].imagepath.toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElevated(
                    icontitle: 'Capture Image',
                    iconmame: Icons.camera,
                    onpressedfunction: () {
                      controller1.fetchCamaraImage();
                      controller1.update();
                    }),
                ButtonElevated(
                    iconmame: Icons.photo_album_outlined,
                    icontitle: 'Gallery Image',
                    onpressedfunction: () {
                      controller1.fetchgalleryimage();
                      controller1.update();
                    })
                // elevated_Button(Icons.camera, , context,
                //     Get.to(data_base())),
                // elevated_Button(Icons.photo_album_outlined, ,
                //     context, Get.to(data_base())),
              ],
            ),
            fillupFormField_edit(
                formTitle: "Student Name",
                keybord_type: TextInputType.name,
                ControllerName: nameController),
            fillupFormField_edit(
                formTitle: "Batch",
                keybord_type: TextInputType.number,
                ControllerName: batchController),
            fillupFormField_edit(
                formTitle: "Domain",
                keybord_type: TextInputType.text,
                ControllerName: domainController),
            fillupFormField_edit(
                formTitle: "Mark scored",
                keybord_type: TextInputType.number,
                // initial_value: student_DB_values.values.toList()[index].Mark,
                ControllerName: markController),
            fillupFormField_edit(
                formTitle: "Mobile Number",
                keybord_type: TextInputType.number,
                ControllerName: mobileController),
            Column(
              children: [
                ButtonElevated(
                    iconmame: Icons.done,
                    icontitle: "Update Student Data",
                    onpressedfunction: () async {
                      final name = nameController.text;
                      final batch = batchController.text;
                      final domain = domainController.text;
                      final mark = markController.text;
                      final mobile = mobileController.text;
                         final imagepath =controller1.image!.path;
                      if (name.isEmpty &&
                          batch.isEmpty &&
                          domain.isEmpty &&
                          mark.isEmpty &&
                          mobile.isEmpty && imagepath.isEmpty) {
                        return;
                      } else {
                        final studentDATA = student_DB(
                            name: name,
                            batch: batch,
                            domain: domain,
                            mark: mark,
                            mobile: mobile,
                            imagepath: controller1.imagepath==null?
                             studentList[index].imagepath.toString() :
                            
                           controller1.imagepath
                            );

                        // final box =
                        //     await Hive.openBox<student_DB>("Student_DB");

                        await controller1.observableBox
                            .putAt(index, studentDATA);
                        controller1.update();
                        Get.to(data_base());
                      }
                    }),
                ButtonElevated(
                  iconmame: Icons.storage_rounded,
                  icontitle: " Cancel",
                  onpressedfunction: () {
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class fillupFormField_edit extends StatelessWidget {
  final String formTitle;

  final TextInputType keybord_type;
  final ControllerName;

  fillupFormField_edit(
      {Key? key,
      required this.formTitle,
      required this.keybord_type,
      this.ControllerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: ControllerName,
        keyboardType: keybord_type,
        cursorHeight: 25,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          labelText: formTitle,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 114, 54, 244),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
