import 'package:flutter/material.dart';
import 'package:pose_tracking/screens/start_screen.dart';
import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarBrightness: Brightness.dark,
  //   ),
  // );
  runApp(const MyApp());
}

// Flutter App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoseTracker',
      theme: ThemeData(
        primaryColor: const Color(0xFF000000),
        secondaryHeaderColor: const Color(0xFF000000),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF36454F),
      ),
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}
