import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final void Function() onPressed;
  final Size size;
  final String text;
  final Color color;

  CustomFlatButton({this.onPressed, this.size, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 18.0, color: Colors.white),
        ),
      ),
      color: color ?? Colors.black,
      highlightElevation: 0,
      highlightColor: Colors.black,
      elevation: 0,
      splashColor: Theme.of(context).accentColor,
    );
  }
}
