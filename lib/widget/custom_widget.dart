import 'package:flutter/material.dart';

class Raised extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color textcolor;
  final Function onPressed;

  const Raised({
    Key key,
    this.color,
    this.textcolor,
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: RaisedButton(
            child: child,
            color: color,
            textColor: textcolor,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
