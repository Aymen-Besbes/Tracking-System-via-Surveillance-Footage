import 'package:flutter/material.dart';
import 'package:pcd_version_finale/screens/login_screen.dart';
import 'package:pcd_version_finale/screens/normal_user_screen.dart';
import 'package:pcd_version_finale/screens/super_user_screen.dart';
import 'signup_screen.dart';
import 'package:pcd_version_finale/widgets/rectangle_button.dart';
import '../utils/utils.dart';

class Home3 extends StatelessWidget {
  const Home3({
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
              Image.asset("images/super.png"),
              SizedBox(height: 50),
              const Text(
                "Locate your target within minutes",
                style: kLargeTextStyle2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 100,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>LoginPage()),
                  );
                },
                child: const Text(
                    "Next",

                    textAlign: TextAlign.right,
                    style: kButtonTextStyle2
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
