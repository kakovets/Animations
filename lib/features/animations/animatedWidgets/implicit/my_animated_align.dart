import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyAnimatedAlignRotation extends StatefulWidget {
  const MyAnimatedAlignRotation({super.key});

  @override
  State<MyAnimatedAlignRotation> createState() => _MyAnimatedAlignRotationState();
}

class _MyAnimatedAlignRotationState extends State<MyAnimatedAlignRotation> {

  bool _isOnTheLeft = true;
  Alignment _alignment = Alignment.centerLeft;
  double _turns = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedAlign(
        alignment: _alignment,
        duration: Utils.duration,
        curve: Curves.easeInBack,
        child: AnimatedRotation(
          turns: _turns,
          duration: Utils.duration,
          child: Container(
            color: Colors.red,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }

  void _toggle() {
    _isOnTheLeft = !_isOnTheLeft;
    setState(() {
      if (_isOnTheLeft) {
        _alignment = Alignment.centerLeft;
        _turns = 0;
      } else {
        _alignment = Alignment.centerRight;
        _turns = 1;
      }
    });
  }
}