import 'dart:math';
import 'package:animations/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiceIconButton extends StatefulWidget {

  /// Dice IconButton,that performs one full rotation,
  /// lifts up and lands down when pressed.
  const DiceIconButton({super.key});

  @override
  State<DiceIconButton> createState() => _DiceIconButtonState();
}

class _DiceIconButtonState extends State<DiceIconButton>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _liftAnimation;

  final double _liftHeight = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Utils.duration,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi,)
        .animate(_controller);

    _liftAnimation = Tween<double>(begin: 0.0, end: _liftHeight,)
        .animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double lift = 2 * min(
          _liftAnimation.value,
          _liftHeight - _liftAnimation.value,
        );
        return Transform.translate(
          offset: Offset(0.0, -lift,),
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/random.svg',
                width: 60,
                height: 60,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                _controller.forward();
                var num = 1 + Random().nextInt(6);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Random num = $num',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}