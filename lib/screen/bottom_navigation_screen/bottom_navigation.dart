// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:machine_test_app/screen/home_screen/home_screen.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/constants/image_class.dart';

import 'empty_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  int selectedIndex;
  BottomNavigationScreen({super.key, required this.selectedIndex});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const EmptyScreen(text: 'Search Screen'),
    const EmptyScreen(text: 'Notification Screen'),
    const EmptyScreen(text: 'Profile Screen'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: _renderBody(isDark),
    );
  }

  _renderBody(bool isDark) {
    return Stack(
      children: [
        _screens[widget.selectedIndex],
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBackground : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded, isDark),
                  _buildNavItem(1, Icons.search, isDark),
                  _buildNavItem(2, Icons.notifications, isDark),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.selectedIndex = 3;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 14,
                        child: Image.asset(ImageClass.darkLogo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            widget.selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Icon(
            icon,
            color: widget.selectedIndex == index
                ? (isDark ? AppColors.white : AppColors.black)
                : (isDark
                    ? AppColors.white.withOpacity(0.5)
                    : AppColors.black.withOpacity(0.5)),
            size: 24,
          ),
        ),
      ),
    );
  }
}
