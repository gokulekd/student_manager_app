import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager_app/controllers/getx_controller.dart';
import 'package:student_manager_app/model/constants/constants.dart';
import 'package:student_manager_app/model/database/student_DB.dart';
import 'package:student_manager_app/views/content/screen_data_base.dart';

class screen_main_page extends StatelessWidget {
  screen_main_page({Key? key}) : super(key: key);

  final Studentcontroller studentcontroller = Get.put(Studentcontroller());

  final nameController = TextEditingController();
  final batchController = TextEditingController();
  final domainController = TextEditingController();
  final markController = TextEditingController();
  final mobileController = TextEditingController();


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Fill Up Student Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
         GetBuilder<Studentcontroller>(
        
          builder: (_){
           return   Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: studentcontroller.image == null
                      ? BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            image: AssetImage("assets/image.png"),
                          ),
                        )
                      : BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: FileImage(File( studentcontroller.image!.path)),
                              fit: BoxFit.cover)),
                ),
              ),
            );
         },
         ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElevated(
                    iconmame: Icons.camera,
                    icontitle: 'Capture Image',
                    onpressedfunction: () async {
                      await studentcontroller.fetchCamaraImage();
                      controller1.update();
                    }),
                ButtonElevated(
                    iconmame: Icons.photo_album_outlined,
                    icontitle: 'Gallery Image',
                    onpressedfunction: () async {
                      await studentcontroller.fetchgalleryimage();
                      controller1.update();
                    })
              ],
            ),
            FillupFormField(
              formTitle: "Student Name",
              keybordType: TextInputType.name,
              controllerName: nameController,
              iconNmae: Icons.school,
              maxlength: 15,
            ),
            FillupFormField(
              formTitle: "Batch",
              keybordType: TextInputType.phone,
              controllerName: batchController,
              iconNmae: Icons.hotel_class_outlined,
              prefixText: "BCE :",
              maxlength: 2,
            ),
            // FillupFormField(
            //   formTitle: "Domain",
            //   keybordType: TextInputType.name,
            //   controllerName: domainController,
            //   iconNmae: Icons.domain,
            //   maxlength: 15,
            // ),
            DropdowmenuHomepage(),
            FillupFormField(
              formTitle: "Mark scored",
              keybordType: TextInputType.number,
              controllerName: markController,
              iconNmae: Icons.credit_score,
              prefixText: "out of 100 :",
              maxlength: 2,
            ),
            FillupFormField(
              formTitle: "Mobile Number",
              keybordType: TextInputType.number,
              controllerName: mobileController,
              iconNmae: Icons.mobile_screen_share_rounded,
              prefixText: " + 91 ",
              maxlength: 10,
            ),
            Column(
              children: [
                ButtonElevated(
                    iconmame: Icons.done,
                    icontitle: "Submit Student Data",
                    onpressedfunction: () async {
                      final name = nameController.text;
                      final batch = batchController.text;
                      final domain = selectedvalue;
                      final mark = markController.text;
                      final mobile = mobileController.text;
                      final imagepath =studentcontroller.image!.path;

                      if (name.isEmpty ||
                          batch.isEmpty ||
                          domain!.isEmpty ||
                          mark.isEmpty ||
                          imagepath.isEmpty ||
                          mobile.isEmpty) {
                        return;
                      } else {
                        final studentDATA = student_DB(
                          name: name,
                          batch: batch,
                          domain: domain,
                          mark: mark,
                          mobile: mobile,
                          imagepath: imagepath,
                        );

                        studentcontroller.createStudent(studentDATA);
                        nameController.clear();
                        batchController.clear();
                        markController.clear();
                        mobileController.clear();
                        controller1.update();
                      }
                    }),
                ButtonElevated(
                  iconmame: Icons.storage_rounded,
                  icontitle: " Go To Data Base",
                  onpressedfunction: () {
                    Get.to(() => data_base());
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

class FillupFormField extends StatelessWidget {
  final String formTitle;

  final TextInputType keybordType;
  // ignore: prefer_typing_uninitialized_variables
  final controllerName;
  final IconData iconNmae;
  final String? prefixText;
  final int? maxlength;
  const FillupFormField(
      {Key? key,
      required this.formTitle,
      required this.keybordType,
      required this.iconNmae,
      this.prefixText,
      this.maxlength,
      this.controllerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //  key: _formkey,
        controller: controllerName,
        keyboardType: keybordType,
        cursorHeight: 25,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(iconNmae),
          prefixText: prefixText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          labelText: formTitle,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 114, 54, 244),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 114, 54, 244),
              width: 1.0,
            ),
          ),
        ),
        maxLength: maxlength,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
        ],
      ),
    );
  }
}

class ButtonElevated extends StatelessWidget {
  final VoidCallback onpressedfunction;
  final IconData iconmame;
  final String icontitle;
  const ButtonElevated(
      {Key? key,
      required this.iconmame,
      required this.icontitle,
      required this.onpressedfunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: const BorderSide(
              color: Color.fromARGB(255, 5, 0, 0),
            ),
          ),
        ),
      ),
      onPressed: onpressedfunction,
      // print("hello guys");

      //  Navigator.of
      //  (context).push(MaterialPageRoute(builder: (context)=>data_base()));

      // ScaffoldMessenger.of(context).removeCurrentSnackBar();
      // Scaffold_messenger(context);

      icon: Icon(iconmame),
      label: Text(icontitle),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Scaffold_messenger(
    context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      backgroundColor: Color.fromARGB(255, 42, 41, 123),
      duration: Duration(milliseconds: 500),
      content: Text(
        " Added to Favourites",
      ),
    ),
  );
}

String? selectedvalue;

class DropdowmenuHomepage extends StatelessWidget {
  DropdowmenuHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(selectedvalue);
    return GetBuilder<Studentcontroller>(
      builder: (controller) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 50,
            width: 375,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 114, 54, 244),
                ),
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButton<String>(
                itemHeight: 60,
                isDense: true,
                isExpanded: true,
                elevation: 0,
                alignment: Alignment.centerLeft,
                hint: Text(dropdownvalue),
                value: selectedvalue == null
                    ? selectedvalue
                    : controller.dropdowncontroll,
                items: domainlist.map(BuildMenuItem).toList(),
                onChanged: (value) async {
                  selectedvalue = value.toString();
                  print(selectedvalue);
                  controller.updateDropdown(value.toString());
                }),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
      alignment: Alignment.center,
      value: item,
      child: Text(
        item,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18),
      ));
}
