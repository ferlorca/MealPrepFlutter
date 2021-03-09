import 'package:flutter/material.dart';

class MPAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      title: Text('Meal Prep App'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
