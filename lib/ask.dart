import 'package:flutter/material.dart';
import 'package:qr_code_app/elevated.dart';

class AskSreen extends StatelessWidget {
  const AskSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to the Navigaurd",
              style: TextStyle(
                fontSize: 28,
                fontWeight:FontWeight.bold
              ),
              ),
              Text("Do you want to install our App",
              style: TextStyle(
                fontSize: 19,
                fontWeight:FontWeight.bold
              ),
              ),
              CustomElevatedButton(
                text: "NaviGaurd",
              ),
              Text("(Only For Android)"),
              Text("Or"),
              Text("Visit our Website"),
              CustomElevatedButton(
                text: "NaviGaurd",
              )
            ],
          ),
        )
      ),
    );
  }
}