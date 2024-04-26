import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyTweenAnimationBuilder extends StatefulWidget {
  const MyTweenAnimationBuilder({super.key});

  @override
  State<MyTweenAnimationBuilder> createState() => _MyTweenAnimationBuilderState();
}

class _MyTweenAnimationBuilderState extends State<MyTweenAnimationBuilder> {

  bool _isBottomedAndRounded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: TweenAnimationBuilder(
        tween: _isBottomedAndRounded
            ? IntTween(begin: 0, end: 20)
            : IntTween(begin: 20, end: 0),
        duration: Utils.duration,
        curve: Curves.ease,
        builder: (_, offset, __) {
          return Transform.translate(
            offset: Offset(0, offset.toDouble()),
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(offset.toDouble()),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: const Icon(
                Icons.co2,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggle() {
    setState(() {
      _isBottomedAndRounded = !_isBottomedAndRounded;
    });
  }
}
