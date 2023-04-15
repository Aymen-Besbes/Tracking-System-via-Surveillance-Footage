import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';

class WelcomePageLoadingScreen extends StatefulWidget {
  @override
  _WelcomePageLoadingScreenState createState() => _WelcomePageLoadingScreenState();
}

class _WelcomePageLoadingScreenState extends State<WelcomePageLoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ColorTween _colorTween;

  @override
  void initState() {
    super.initState();
    // initialisation du controller d'animation
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // définition de la plage de la couleur d'animation
    _colorTween = ColorTween(begin: Colors.blue, end: Colors.red);
    // définition de l'animation de l'indicateur de progression circulaire
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    // démarrage de l'animation
    _controller.repeat();
    // démarrage d'un timer pour passer à la page de connexion après 5 secondes
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    // libération des ressources utilisées par le controller d'animation
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // animation de l'indicateur de progression circulaire
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 80.0,
                  height: 80.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    valueColor: _colorTween.animate(_animation),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            // texte "Chargement en cours"
            Text(
              'Chargement en cours...',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            // logo de l'application
            SvgPicture.asset(
              'images/logo.png',
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
