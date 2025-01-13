// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_app/components/sized_box.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/constants/image_class.dart';
import 'package:machine_test_app/screen/bottom_navigation_screen/bottom_navigation.dart';
import 'package:machine_test_app/screen/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavigationScreen(
                  selectedIndex: 0,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: _renderBody(),
    );
  }

  _renderBody() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kHeight(
                100.0,
              ),
              Image.asset(
                ImageClass.darkLogo,
                height: 100,
                width: 100,
              ),
              kHeight(
                40.0,
              ),
              const CupertinoActivityIndicator(
                color: Colors.black,
              ),
              kHeight(
                100.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}
