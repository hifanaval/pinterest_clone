import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/constants/textstyle_class.dart';
import 'package:toastification/toastification.dart';

class AppUtils {
  static get http => null;

  /// Navigate to a new screen/widget
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  ///To check internet connection
  ///To check internet connection
  static Future<bool> hasInternet() async {
    if (kIsWeb) {
      // For web, we'll return true since the browser handles connectivity
      return true; // Web browsers handle offline state automatically
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
      return false;
    }
  }

  static showToast(
      BuildContext context, String labelText, String message, bool isSuccess) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper

      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        labelText,
        style: TextStyleClass.primaryFont500(
            14, isSuccess ? AppColors.success : AppColors.error),
      ),
      description: Text(
        message,
        style: TextStyleClass.primaryFont500(
            12, isSuccess ? AppColors.success : AppColors.error),
      ),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 500),

      icon: Icon(isSuccess ? Icons.check : Icons.error_outline_rounded,
          color: isSuccess ? AppColors.success : AppColors.error),
      showIcon: true, // show or hide the icon
      primaryColor: isSuccess ? AppColors.success : AppColors.error,
      backgroundColor: AppColors.white,
      // foregroundColor: const Color.fromARGB(255, 77, 70, 70),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 0,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
      borderSide: const BorderSide(color: AppColors.lightSecondary),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      style: ToastificationStyle.minimal,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            debugPrint('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            debugPrint('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            debugPrint('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  static loadingWidget(BuildContext context) {
    return const Center(
        child: CupertinoActivityIndicator(
      radius: 10.0,
      color: AppColors.white,
    ));
  }
}
