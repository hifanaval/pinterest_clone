import 'package:flutter/material.dart';
import 'package:machine_test_app/provider/image_provider.dart';
import 'package:provider/provider.dart';

import 'constants/color_class.dart';
import 'screen/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ImageDataProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeStyles.lightTheme(),
        darkTheme: ThemeStyles.darkTheme(),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
