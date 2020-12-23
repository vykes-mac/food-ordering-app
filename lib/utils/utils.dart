import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bottomLoader() => Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33.0,
          height: 33.0,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );

String doubleToCurrency(double value) {
  var formatter =
      new NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2);
  return formatter.format(value);
}
