import 'package:flutter/material.dart';
import 'package:pcd_version_finale/screens/login_screen.dart';
import 'package:pcd_version_finale/screens/welcome_page_3.dart';

import 'package:pcd_version_finale/widgets/rectangle_button.dart';
import '../utils/utils.dart';

class Home2 extends StatelessWidget {
  const Home2({
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
              Image.asset("images/play_video.png"),
              const Text(
                "Supervise your local anytime anywhere with a simple clic",
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
                    MaterialPageRoute(builder: (context) => Home3()),
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
