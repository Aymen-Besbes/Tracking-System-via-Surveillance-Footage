import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
class RectangleButton2 extends StatelessWidget {
  const RectangleButton2({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(

        decoration: BoxDecoration(

          shape: BoxShape.rectangle,
          color: Colors.white54,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}