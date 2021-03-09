import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;
  GenericButton(
      {@required this.color, @required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Text(text),
      ),
    );
  }
}
