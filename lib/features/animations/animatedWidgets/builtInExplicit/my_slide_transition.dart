import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MySlideTransition extends StatefulWidget {
  const MySlideTransition({super.key});

  @override
  State<MySlideTransition> createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {

  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  bool _isSlided = false;

  @override
  void initState() {
    super.initState();

    _slideAnimationController = AnimationController(
      duration: Utils.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -15),
    ).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: Curves.easeInOutQuint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Switch(
          value: _isSlided,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              _isSlided = value;
              if (_isSlided) {
                _slideAnimationController.forward();
              } else {
                _slideAnimationController.reverse();
              }
            });
          },
        ),
        SlideTransition(
          position: _slideAnimation,
          child: const Icon(Icons.slideshow),
        ),
      ],
    );
  }
}