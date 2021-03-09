import 'package:flutter/material.dart';
import 'package:mealprepapp/components/user/mp_user_info.dart';
import 'package:mealprepapp/components/user/mp_user_list_tile.dart';
import 'package:mealprepapp/models/models/user.dart';
import 'package:mealprepapp/models/providers/user_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const route = "user_screen";

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User> userList = [];
  @override
  void initState() {
    userList = context.read<UserData>().users;
    if (userList.length == 0) context.read<UserData>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final aux = context
        .watch<UserData>() //Provider.of<UserData>(context)
        .users;
    return ModalProgressHUD(
      inAsyncCall: context.watch<UserData>().loading,
      child: Scaffold(
        body: ListView(
          children: aux
              .map(
                (e) => Container(
                  key: Key(e.id),
                  margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: Dismissible(
                    key: Key(e.id),
                    onDismissed: (DismissDirection direction) {
                      context.read<UserData>().deleteUser(e.id);
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      color: Colors.red.shade700,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.delete,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      color: Colors.red.shade700,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: FlatButton(
                      color: Colors.blueGrey.shade700,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfoPage(
                                      user: e,
                                    )));
                      },
                      child: UserListTile(
                        user: e,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                          user: null,
                        )));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}

//
//Flexible(
//child: Center(
//child: FlatButton(
//onPressed: () {
//context.read<UserData>().deleteUser(e.id);
//},
//child: Icon(
//Icons.delete,
//size: 30.0,
//color: Colors.blueGrey.shade800,
//),
//),
//),
//)
