import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:work/utilities/app_color.dart';

class Utils {
  static showFlushBarWithMessage(
    String msg,
    BuildContext context,
  ) {
    Flushbar(
      //title: status ? "Success" : "Error",
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(10),
      backgroundColor: appFlushColor,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.easeOutSine,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      positionOffset: 20,
      message: msg,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
