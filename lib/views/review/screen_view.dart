import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_manager_app/controllers/getx_controller.dart';
import 'package:student_manager_app/model/database/student_DB.dart';
import 'package:student_manager_app/views/home/homepage.dart';
import 'package:student_manager_app/views/update/Screen_edit_Student.dart';

class screen_view extends StatelessWidget {
  final int index;
  screen_view({Key? key, required this.index}) : super(key: key);
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Data"),
      ),
      body: GetBuilder<Studentcontroller>(
        builder: (controller) {
          List<student_DB> studentList =
              controller.observableBox.values.toList();
          return SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(80)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.file(
                          File(
                            studentList[index].imagepath.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        const Text(
                          "Name  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          studentList[index].name,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          "Batch  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          studentList[index].batch,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          "Domain  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          studentList[index].domain,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          "Mark  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          studentList[index].mark,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          "mobile NO  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          "+91${studentList[index].mobile}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ]),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ButtonElevated(
                        iconmame: Icons.edit,
                        icontitle: "Edit Data",
                        onpressedfunction: () {
                          Get.to(ScreeneEditStudent(index: index));
                        }),
                    ButtonElevated(
                        iconmame: Icons.cancel,
                        icontitle: "Go Back",
                        onpressedfunction: () {
                          Get.back();
                        }),
                  ],
                )

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         const Text(
                //           "Name",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //         const Text(
                //           ":",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Text(
                //           "Batch",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //         const Text(
                //           ":",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Text(
                //           "Domain",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //         //  const Text(
                //         //     ":",
                //         //     style: TextStyle(fontSize: 25),
                //         //   ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Text(
                //           "Mark Scored",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //         const Text(
                //           ":",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Text(
                //           "Mobile No  :",
                //           style: TextStyle(fontSize: 25),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       studentList[index].name,
                //       style: TextStyle(fontSize: 25),
                //     ),
                //     Text(
                //       studentList[index].batch,
                //       style: TextStyle(fontSize: 25),
                //     ),
                //     Text(
                //       studentList[index].domain,
                //       style: TextStyle(fontSize: 25),
                //     ),
                //     Text(
                //       studentList[index].mark,
                //       style: TextStyle(fontSize: 25),
                //     ),
                //     Text(
                //       studentList[index].mobile,
                //       style: TextStyle(fontSize: 25),
                //     ),
                //   ],
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
