import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class NotificationProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  int counter = 0;
  NotificationProvider(this.prefs) {
    counter = prefs.getInt(noOfNotification)!;
  }
  void setCounter(int c) {
    log('setCounter');
    int counter2 = prefs.getInt(noOfNotification)! + 1;
    prefs.setInt(noOfNotification, counter2);
    counter = counter2;
    notifyListeners();
  }

  void setZero() {
    log('zeroCounter');
    prefs.setInt(noOfNotification, 0);
    counter = 0;
    notifyListeners();
  }
}
