import 'package:flutter/material.dart';
import 'dart:async' ;
class DelayedAnimation extends StatefulWidget {


  final Widget child;

  final int delay;

  const DelayedAnimation({ required this.delay, required this.child});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}
class _DelayedAnimationState extends State<DelayedAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller ; // controller les animation
  late Animation<Offset> _animOffset ; // preciser le comportement de notre animation

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );
    _animOffset = Tween<Offset>
      (
      begin: Offset(0.0, -2),
      end: Offset.zero,
    ).animate(curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    }); // gerer la duree d'aparition du widget
  }


  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.decelerate,
        ),
      ),
      child:SlideTransition(
        position: _animOffset,
        child:widget.child,
      ),

    );

  }
}