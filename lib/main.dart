import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pcd_version_finale/screens/welcome_page.dart';
import 'package:pcd_version_finale/screens/delayed_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'check up',
      debugShowCheckedModeBanner: false, // enlever le banner au coin
      home:WelcomePageLoadingScreen(),
    );
  }
}