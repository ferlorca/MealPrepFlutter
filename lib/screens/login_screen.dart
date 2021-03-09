import 'package:flutter/material.dart';
import 'package:mealprepapp/models/providers/auth_data.dart';
import 'package:mealprepapp/screens/home_screen.dart';
import 'package:mealprepapp/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const route = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
//  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: context.watch<AuthData>().loading,
        child: SafeArea(
          child: Container(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    "Meal Prep App",
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.lightGreen),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20.0),
                  child: MaterialButton(
                    onPressed: () async {
                      final user = await context
                          .read<AuthData>()
                          .loginUserWithEmailAndPassword(email, password);
                      if (user != null) {
                        Navigator.pushNamed(context, HomeScreen.route);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      "Ingresar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20.0),
                  child: MaterialButton(
                    onPressed: () async {
                      final user = await context
                          .read<AuthData>()
                          .registerUserWithEmailAndPassword(email, password);
                      if (user != null) {
                        Navigator.pushNamed(context, HomeScreen.route);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      "Registrarse",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (context.watch<AuthData>().error != null)
                  Text(context.watch<AuthData>().error.message)
              ],
            ),
          )),
        ),
      ),
    );
  }
}
