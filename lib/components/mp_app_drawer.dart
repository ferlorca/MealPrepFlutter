import 'package:flutter/material.dart';
import 'package:mealprepapp/models/providers/auth_data.dart';
import 'package:mealprepapp/screens/initial_screen.dart';
import 'package:provider/provider.dart';

class MPDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Mi perfil'),
            onTap: () {
              print("go to perfil");
            },
          ),
          ListTile(
            title: Text('Quienes Somos'),
            onTap: () {
              print("go to about us");
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              context.read<AuthData>().singOut();
              Navigator.pushNamed(context, InitialScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
