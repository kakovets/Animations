import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyAnimatedContainer extends StatefulWidget {
  const MyAnimatedContainer({super.key});

  @override
  State<MyAnimatedContainer> createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {

  Color _containerColor = Colors.pink;
  double _containerBorderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        height: 100,
        decoration: BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(_containerBorderRadius),
        ),
        duration: Utils.duration,
      ),
    );
  }

  void _toggle() {
    setState(() {
      _containerBorderRadius = 50 * Random().nextDouble();
      _containerColor = Color(0xFF000000 | Random().nextInt(0xFFFFFF));
    });
  }
}
