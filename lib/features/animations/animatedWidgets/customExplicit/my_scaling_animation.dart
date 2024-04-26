import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyScalingAnimation extends StatefulWidget {
  const MyScalingAnimation({super.key});

  @override
  State<MyScalingAnimation> createState() => _MyScalingAnimationState();
}

class _MyScalingAnimationState extends State<MyScalingAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;
  bool _isShown = false;

  @override
  void initState() {
    super.initState();

    _scaleAnimationController = AnimationController(
      duration: Utils.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 200)
        .animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.slowMiddle,
      ),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Switch(
          value: _isShown,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              _isShown = value;
              if (_isShown) {
                _scaleAnimationController.forward();
              } else {
                _scaleAnimationController.reverse();
              }
            });
          },
        ),
        Image.asset(
          'assets/misha.jpeg',
          width: _scaleAnimation.value,
        ),
      ],
    );
  }
}