import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyAnimatedOpacity extends StatefulWidget {
  const MyAnimatedOpacity({super.key});

  @override
  State<MyAnimatedOpacity> createState() => _MyAnimatedOpacityState();
}

class _MyAnimatedOpacityState extends State<MyAnimatedOpacity> {

  bool _isShown = false;
  double _opacity = 0;

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
              _opacity = _isShown ? 1 : 0;
            });
          },
        ),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Utils.duration,
          child: const Text(
            'Купіть хітер пліз',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}