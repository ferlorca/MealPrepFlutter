import 'package:flutter/material.dart';
import 'package:mealprepapp/controller/home_controller.dart';
import 'package:mealprepapp/models/providers/auth_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const route = "home_screen";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<AuthData>().role == null,
      child: SafeArea(
        child: context.watch<AuthData>().role != null
            ? HomeController(role: context.watch<AuthData>().role)
            : Center(
                child: SizedBox(
                  height: 20.0,
                ),
              ),
      ),
    );
  }
}
