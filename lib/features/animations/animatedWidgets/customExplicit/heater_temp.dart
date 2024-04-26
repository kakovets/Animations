import 'dart:async';
import 'package:flutter/material.dart';

class HeaterTemp extends StatefulWidget {
  const HeaterTemp({super.key});

  @override
  State<HeaterTemp> createState() => _HeaterTempState();
}

class _HeaterTempState extends State<HeaterTemp>
    with SingleTickerProviderStateMixin {

  late AnimationController _ambTempAnimController;
  late Animation<double> _ambTempOpacityAnim;

  bool _isCelsius = true;
  double _temporaryAmbTemp = 20;
  Timer? _ambTempAnimTimer;
  Timer? _longPressTimer;
  final double _pressDuration = 100;

  @override
  void initState() {
    super.initState();

    // Ambient
    _ambTempAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _ambTempOpacityAnim = Tween<double>(
      begin: 1.0,
      end: 0.1,
    ).animate(_ambTempAnimController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ambTempAnimController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _ambTempAnimController.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: Text('Fahrenheit', textAlign: TextAlign.end,)),
              const SizedBox(width: 8,),
              Switch(
                value: _isCelsius,
                onChanged: (value) {
                  setState(() {
                    _isCelsius = !_isCelsius;
                  });
                  if (_isCelsius) {
                    _temporaryAmbTemp = ((_temporaryAmbTemp - 32) / 1.8)
                        .roundToDouble();
                    _temporaryAmbTemp = (_temporaryAmbTemp * 2)
                        .roundToDouble() / 2;
                  } else {
                    _temporaryAmbTemp =
                        (_temporaryAmbTemp * 1.8).round() + 32;
                  }
                },
              ),
              const SizedBox(width: 8,),
              const Expanded(child: Text('Celsius', textAlign: TextAlign.start)),
            ],
          ),
          Text(
            'Room temperature, \xb0${_isCelsius ? 'C' : 'F'}:',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Minus
              GestureDetector(
                onTap: () {
                  if (_isInRange(incrementing: false)) {
                    _updateAmbTemp(delta: _isCelsius ? -0.5 : -1);
                  } else {
                    // Fluttertoast.showToast(
                    //     msg: LocaleKeys.room_temp_target_temp_min_reached.tr(),
                    // );
                  }
                },
                onLongPress: () {
                  _startDecrTimer();
                },
                onLongPressEnd: (_) => _longPressTimer?.cancel(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 70.0,
                      height: 50.0,
                    ),
                  ],
                ),
              ),

              // Target Ambient
              AnimatedBuilder(
                animation: _ambTempOpacityAnim,
                builder: (context, child) {
                  return Opacity(
                    opacity: _ambTempOpacityAnim.value,
                    child: Text(
                      '${_isCelsius ? _temporaryAmbTemp : _temporaryAmbTemp.toInt()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  );
                },
              ),

              // Plus
              GestureDetector(
                onTap: () {
                  if (_isInRange(incrementing: true)) {
                    _updateAmbTemp(delta: _isCelsius ? 0.5 : 1);
                  } else {
                    // Fluttertoast.showToast(
                    //     msg: LocaleKeys.room_temp_target_temp_max_reached.tr(),
                    // );
                  }
                },
                onLongPress: () {
                  _startIncrTimer();
                },
                onLongPressEnd: (_) => _longPressTimer?.cancel(),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 70.0,
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ambTempAnimTimer?.cancel();
    _longPressTimer?.cancel();
    _ambTempAnimController.dispose();
    super.dispose();
  }

  bool _isInRange({required bool incrementing}) {
    final double lowerLimit = _isCelsius ? 5.5 : 42;
    final double upperLimit = _isCelsius ? 34.5 : 94;

    if (incrementing) {
      return _temporaryAmbTemp <= upperLimit;
    } else {
      return _temporaryAmbTemp >= lowerLimit;
    }
  }

  void _updateAmbTemp({required double delta}) {

    _temporaryAmbTemp += delta;

    if (_ambTempAnimController.status == AnimationStatus.forward
        || _ambTempAnimController.status == AnimationStatus.dismissed) {
      _ambTempAnimController.forward(from: _ambTempAnimController.value);
    } else {
      _ambTempAnimController.reverse(from: _ambTempAnimController.value);
    }
    _ambTempAnimTimer?.cancel();
    _ambTempAnimTimer = Timer(const Duration(milliseconds: 2500), () async {
      await _ambTempAnimController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
      );
      _ambTempAnimController.stop();
    });
  }

  void _startDecrTimer() {
    _longPressTimer = Timer.periodic(
      Duration(milliseconds: _pressDuration.toInt()),
          (timer) {
        if (_isInRange(incrementing: false)) {
          _updateAmbTemp(delta: _isCelsius ? -0.5 : -1);
        } else {
          timer.cancel();
        }
      },
    );
  }

  void _startIncrTimer() {
    _longPressTimer = Timer.periodic(
      Duration(milliseconds: _pressDuration.toInt()),
          (timer) {
        if (_isInRange(incrementing: true)) {
          _updateAmbTemp(delta: _isCelsius ? 0.5 : 1);
        } else {
          timer.cancel();
        }
      },
    );
  }
}