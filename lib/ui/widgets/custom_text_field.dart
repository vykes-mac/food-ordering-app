import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Function(String val) onChanged;

  CustomTextField({
    this.hint,
    this.fontSize,
    this.fontWeight,
    this.onChanged,
  });

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.overline.copyWith(
              color: Colors.black,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
          enabledBorder: _border,
          border: _border,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor,
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
    );
  }
}
