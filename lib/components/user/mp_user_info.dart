import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mealprepapp/models/models/user.dart';
import 'package:mealprepapp/models/providers/user_data.dart';
import 'package:mealprepapp/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../mp_app_bar.dart';
import '../ganeric/mp_generics_button.dart';

class UserInfoPage extends StatefulWidget {
  final User user;
  UserInfoPage({this.user});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  String role;
  final _formKey = GlobalKey<FormState>();
  List<String> roles = [];

  @override
  void initState() {
    roles = context.read<UserData>().roles;
    if (roles.length == 0) context.read<UserData>().getRoles();
    emailController.text = widget.user != null ? widget.user.email : "";
    nameController.text = widget.user != null ? widget.user.displayName : "";
    role = widget.user != null ? widget.user.role : "user";
    super.initState();
  }

  DropdownButtonFormField getAndroidPicker(List<String> rolesToFill) {
    var list = List<DropdownMenuItem>();
    for (String item in rolesToFill) {
      list.add(
        DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(item),
          ),
          value: item,
        ),
      );
    }

    return DropdownButtonFormField(
        value: role,
        isExpanded: true,
        items: list,
        onChanged: (value) {
          setState(() {
            role = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Email",
                ),
                validator: (val) => val == "" ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: nameController,
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Nombre",
                ),
              ),
              getAndroidPicker(
                  roles.length == 0 ? context.watch<UserData>().roles : roles),
              TextFormField(
                controller: passController,
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Contraseña",
                ),
                validator: (val) =>
                    val.length < 6 ? 'Contraseña muy corta.' : null,
                obscureText: true,
              ),
              TextFormField(
                controller: repeatPassController,
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: "Repetir Contraseña",
                ),
                obscureText: true,
                validator: (val) => val != passController.text
                    ? 'Las contraseñas deben coincidir.'
                    : null,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GenericButton(
                      text: widget.user != null ? "Modificar" : "Agregar",
                      color: Colors.teal,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          final Map<String, String> data = {
                            "displayName": nameController.text,
                            "email": emailController.text,
                            "role": role,
                            "password": passController.text,
                          };
                          context
                              .read<UserData>()
                              .addOrUpdateUser(widget.user, data);
                          Navigator.pop(context);
                        }
                      },
                    ),
                    GenericButton(
                      text: "Cancelar",
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
