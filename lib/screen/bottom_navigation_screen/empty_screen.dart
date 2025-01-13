import 'package:flutter/material.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/constants/textstyle_class.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Center(
        child: Text(
          text,
          style: TextStyleClass.primaryFont500(
            14,
            isDark ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
