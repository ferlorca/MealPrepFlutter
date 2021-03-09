import 'package:flutter/material.dart';
import 'package:mealprepapp/models/models/user.dart';

class UserListTile extends StatelessWidget {
  final User user;
  UserListTile({@required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.role == "admin" || user.role == "moderator"
          ? Icon(
              Icons.supervised_user_circle,
              size: 40.0,
            )
          : Icon(
              Icons.account_circle,
              size: 40.0,
            ),
      title: Text(user.displayName),
      dense: true,
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Email: " + user.email),
          Text("Rol: " + user.role),
        ],
      ),
    );
  }
}
