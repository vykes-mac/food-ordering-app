import 'package:flutter/material.dart';

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
