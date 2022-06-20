import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_manager_app/controllers/getx_controller.dart';
import 'package:student_manager_app/model/database/student_DB.dart';
import 'package:student_manager_app/views/review/screen_view.dart';
import 'package:student_manager_app/views/update/Screen_edit_Student.dart';

final Studentcontroller controller1 = Get.put(Studentcontroller()); //

class data_base extends StatelessWidget {
  data_base({Key? key}) : super(key: key);
  final Studentcontroller controller1 = Get.put(Studentcontroller()); //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Data"),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Color.fromARGB(255, 69, 108, 155),
                    title: const Text('Delete Student Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                    content: const Text(
                        " Do you want to Delete  This Student Data",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(
                          context,
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          //  await controller1.observableBox.clear();
                          //   controller1.update();
                          controller1.deleteAllStudent();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                  bottom: 75, right: 10, left: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              backgroundColor: Color.fromARGB(255, 42, 41, 123),
                              content: Text(" deleted"),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 132, 60, 55),
              ),
              label: const Text("Delete All"))
        ],
      ),
      body: SafeArea(
        child:
            //Obx(() =>
            GetBuilder<Studentcontroller>(builder: (controller) {
          List<student_DB> studentList =
              controller1.observableBox.values.toList();

          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(screen_view(
                      index: index,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 155, 186, 223)),
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              File(
                                controller.observableBox.values.toList()[index].imagepath.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(studentList[index].name),
                        subtitle: Text("Batch No :" + studentList[index].batch),
                        trailing: IconButton(
                            onPressed: () async {
                              await controller1.observableBox.deleteAt(index);

                              controller1.update();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ));
            },
          );
        }),
        //),
      ),
    );
  }
}

class studentTileDataBase extends StatelessWidget {
  final int index;

  studentTileDataBase({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(Studentcontroller());
    final controller = Get.find<Studentcontroller>();
    List<student_DB> studentList = controller.observableBox.values.toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 155, 186, 223)),
        child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:
                    Image.file(File(studentList[index].imagepath.toString()))),
            title: Text(studentList[index].name.toString()),
            subtitle: Text("Batch No :" + studentList[index].batch),
            trailing: PopUp_Menu_Data_base(
              index: index,
            )),
      ),
    );
    //   },
    // );
  }
}

class PopUp_Menu_Data_base extends StatelessWidget {
  final int index;
  const PopUp_Menu_Data_base({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Color.fromARGB(255, 69, 108, 155),
        elevation: 20,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
        onSelected: (value) async {
          if (value == 1) {
            Get.to(() => ScreeneEditStudent(index: index));
          }

          if (value == 2) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: Color.fromARGB(255, 69, 108, 155),
                title: const Text('Delete Student Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
                content: const Text(" Do you want to Delete  This Student Data",
                    style: TextStyle(color: Colors.white)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(
                      context,
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () async {
                      controller1.observableBox.deleteAt(index);

                      controller1.update();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          margin:
                              EdgeInsets.only(bottom: 75, right: 10, left: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          backgroundColor: Color.fromARGB(255, 42, 41, 123),
                          content: Text(" deleted"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Done',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
        });
  }
}
