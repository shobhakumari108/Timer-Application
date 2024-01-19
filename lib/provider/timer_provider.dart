import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;

  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  bool _isTimeSet = false;

  int get minute => _minute;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  bool get isTimeSet => _isTimeSet;

  // Getter for formatted time in 'mm:ss' format
  String get formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(_minute)}:${twoDigits(_seconds)}';
  }

  // Set the duration of the timer
  void setTimerDuration(
    int seconds,
    int minutes,
  ) {
    _minute = minutes;
    _seconds = seconds;

    // Convert seconds to minutes if it's greater than or equal to 60
    if (_seconds >= 60) {
      _minute += _seconds ~/ 60;
      _seconds %= 60;
    }

    _isTimeSet = true; // Update the variable when time is set
    notifyListeners();
  }

  // Start the timer
  void startTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0 || _minute > 0) {
        if (_seconds == 0) {
          _minute--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      } else {
        // Timer reached zero, stop the timer
        stopTimer();
      }

      notifyListeners();
    });
  }

  // Stop the timer
  void stopTimer() {
    _startEnable = true;
    _continueEnable = true;
    _stopEnable = false;
    _timer.cancel();
    notifyListeners();
  }

  
}
