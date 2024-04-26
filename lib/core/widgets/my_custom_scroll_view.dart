import 'package:flutter/material.dart';

class MyCustomScrollView extends StatelessWidget {
  const MyCustomScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
