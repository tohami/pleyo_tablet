import 'dart:async';
import 'package:flutter/material.dart';

class InactivityRedirectService with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  void Function()? onTimeout;
  
  InactivityRedirectService({this.onTimeout});

  void startListening() {
    WidgetsBinding.instance.addObserver(this);
    _resetTimer();
  }

  void stopListening() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(minutes: 3), () {
      // Call the callback when the timer fires
      onTimeout?.call();
    });
  }

  // Call this method on user interactions
  void userInteracted() {
    _resetTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _resetTimer();
    } else {
      _inactivityTimer?.cancel();
    }
  }
}
