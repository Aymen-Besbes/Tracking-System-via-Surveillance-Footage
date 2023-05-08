import 'package:flutter/material.dart';
import 'package:pcd_version_finale/screens/login_screen.dart';
import 'package:pcd_version_finale/screens/welcome_page_2.dart';

import 'package:pcd_version_finale/widgets/rectangle_button.dart';
import '../utils/utils.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/Welcome-amico.png"),
              const Text(
                "Welcome to CheckApp",
                style: kLargeTextStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 50,
              ),
              RectangleButton(

                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home2(),
                    )),
                child: const Text(
                  "Let's get started",
                  style: kButtonTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
