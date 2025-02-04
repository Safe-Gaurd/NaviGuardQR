import 'package:flutter/material.dart';
import 'package:qr_code_app/elevated.dart';

class AskScreen extends StatelessWidget {
  const AskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade600,
                Colors.blue.shade300
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to NaviGuard!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Do you want to install our App?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                CustomElevatedButton(
                  text: "Install NaviGuard",
                  textStyle: TextStyle(color: Colors.blue),
                  onPressed: () {
                    // Handle button action
                  },
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 15),
                Text(
                  "(Only For Android)",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Visit our Website",
                  textStyle: TextStyle(color: Colors.blue),
                  onPressed: () {
                    // Handle button action
                  },
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
