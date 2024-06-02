import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

dynamic showToast({
  required String msg,
  required Color backgroundColor,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
