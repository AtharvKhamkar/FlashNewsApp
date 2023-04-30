import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flashnewsapp/constants/colorConstants.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.toNamed('/homePage');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Image.asset('assets/FlashNews.png'),
      ),
    );
  }
}
