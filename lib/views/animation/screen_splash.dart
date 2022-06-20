import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../views/home/homepage.dart';

class Screensplash extends StatelessWidget {
  const Screensplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splash_navigator(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 188, 234),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("STUDENT MANAGER",
                  style: GoogleFonts.montserrat(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 52, 103))),
              Container(
                width: 150,
                height: 150,
                child: Lottie.asset("assets/splash-loading.json"),
              ),
              Container(
                  width: 350,
                  height: 350,
                  child: Lottie.asset("assets/splash.json")),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> splash_navigator(context) async {
  await Future.delayed(Duration(seconds: 3));
Get.to(screen_main_page());
}
