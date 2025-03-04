import 'package:flutter/material.dart';
import 'package:qr_code_app/screens/Responsive_layout.dart';
import 'package:qr_code_app/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaviGuard',
      home: ResponsiveScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
