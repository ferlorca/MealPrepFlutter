import 'package:flutter/material.dart';
import 'package:mealprepapp/models/providers/auth_data.dart';
import 'package:mealprepapp/screens/home_screen.dart';
import 'package:mealprepapp/screens/login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  static const route = "initial_screen";

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  void changeScreen() async {
    final user = await context.read<AuthData>().getCurrentUserFromFirebase();
    if (user == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    } else {
      await context.read<AuthData>().updateAuthDataWithUser(user);
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    }
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: context.watch<AuthData>().loading,
        child: Center(
          child: Container(
            child: Text("Espere unos segundos..."),
          ),
        ),
      ),
    );
  }
}
