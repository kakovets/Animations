import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyFadeTransition extends StatefulWidget {
  const MyFadeTransition({super.key});

  @override
  State<MyFadeTransition> createState() => _MyFadeTransitionState();
}

class _MyFadeTransitionState extends State<MyFadeTransition>
    with SingleTickerProviderStateMixin {

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  bool _isShown = false;

  @override
  void initState() {
    super.initState();

    _fadeAnimationController = AnimationController(
      duration: Utils.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_fadeAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Switch(
          value: _isShown,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              _isShown = value;
              if (_isShown) {
                _fadeAnimationController.forward();
              } else {
                _fadeAnimationController.reverse();
              }
            });
          },
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: const Icon(Icons.hide_source),
        ),
      ],
    );
  }
}