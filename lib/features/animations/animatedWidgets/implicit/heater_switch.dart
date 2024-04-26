import 'dart:async';
import 'package:flutter/material.dart';

class HeaterSwitch extends StatefulWidget {
  const HeaterSwitch({super.key});

  @override
  State<HeaterSwitch> createState() => _HeaterSwitchState();
}

class _HeaterSwitchState extends State<HeaterSwitch> {

  bool _isPoweredOn = false;
  bool _isPowerBlocked = false;
  Timer? _powerTimer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: _togglePower,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Power',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: _getSwitchPowerColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                      top: 2.5,
                      left: _isPoweredOn ? 25 : 2.5,
                      right: _isPoweredOn ? 2.5 : 25,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _powerTimer?.cancel();
    super.dispose();
  }

  void _togglePower() {
    if (!_isPowerBlocked) {
      setState(() {
        _isPowerBlocked = true;
        _isPoweredOn = !_isPoweredOn;
      });
      _powerTimer?.cancel();
      _powerTimer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _isPowerBlocked = false;
        });
      });
    }
  }

  Color _getSwitchPowerColor() {
    if (_isPowerBlocked) {
      return Colors.grey.withOpacity(0.4);
    }
    return _isPoweredOn ? Colors.lightGreenAccent.shade700 : Colors.grey;
  }
}