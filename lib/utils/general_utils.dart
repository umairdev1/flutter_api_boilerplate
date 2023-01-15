import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (var i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }

    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          padding: const EdgeInsets.all(15),
          message: message,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          reverseAnimationCurve: Curves.easeInOut,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        )..show(context));
  }
}
