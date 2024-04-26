import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key});

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with TickerProviderStateMixin {

  late AnimationController _curvedAnimationController;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _curvedAnimationController = AnimationController(
      duration: Utils.duration,
      vsync: this,
    )..repeat(reverse: true);

    _curvedAnimation = CurvedAnimation(
      parent: _curvedAnimationController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScalingContainer(animation: _curvedAnimation);
  }

  @override
  void dispose() {
    _curvedAnimationController.dispose();
    super.dispose();
  }
}

class ScalingContainer extends AnimatedWidget {
  const ScalingContainer({
    super.key,
    required Animation animation,
  }) : super(listenable: animation);

  Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 * _animation.value,
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(150 * _animation.value),
      ),
      child: Center(
        child: Text(
          'Ribbit ribbit',
          style: TextStyle(
            fontSize: 40 * _animation.value,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}