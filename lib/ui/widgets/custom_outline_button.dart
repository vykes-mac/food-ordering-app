import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final Size size;
  final String text;

  CustomOutlineButton({
    this.text,
    this.icon,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: OutlineButton.icon(
        onPressed: onPressed,
        highlightedBorderColor: Colors.black,
        borderSide: BorderSide(width: 1.5, color: Colors.black),
        shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
        icon: icon ?? Container(),
        label: Text(
          text,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
        ),
        color: Colors.white,
        highlightColor: Colors.white,
        splashColor: Theme.of(context).accentColor,
      ),
    );
  }
}
