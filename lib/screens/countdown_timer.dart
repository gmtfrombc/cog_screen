// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class CountdownTimer extends StatefulWidget {
  final VoidCallback onTimerComplete;

  const CountdownTimer({super.key, required this.onTimerComplete});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _remainingSeconds = 15;

  void _startTimer() {
    _remainingSeconds = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        widget.onTimerComplete();
        _triggerVibration();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1000); // Vibrate for 1 second
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.primaryBackgroundColor, // Off white background
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryColor, // Deep green
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$_remainingSeconds',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor, // Muted blue
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: surveyProvider.isTimerButtonEnabled
              ? () {
                  surveyProvider.startTimer();
                  _startTimer();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor, // Deep green
            foregroundColor: Colors.white, // Text color
          ),
          child: const Text('Start Timer'),
        ),
      ],
    );
  }
}
