import 'package:flutter/material.dart';
import 'package:mealprepapp/models/providers/user_data.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {
  static const route = "error_screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        context.watch<UserData>().error != null
            ? context.watch<UserData>().error.message
            : "",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
