import 'package:flutter/material.dart';
import 'package:mealprepapp/components/mp_app_bar.dart';
import 'package:mealprepapp/components/mp_app_bottonnavigatorbar.dart';
import 'package:mealprepapp/components/mp_app_drawer.dart';
import 'package:mealprepapp/utilities/constants.dart';

class HomeController extends StatefulWidget {
  final String role;
  HomeController({this.role});

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int selectedItem = 0;
  List<Map> permitedViews = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      permitedViews = kViews
          .where((element) =>
              element["role"] == null || element["role"].contains(widget.role))
          .toList();
    });
  }

  void onItemTapped(index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(),
      endDrawer: MPDrawer(),
      body: permitedViews[selectedItem]["widget"],
      bottomNavigationBar: MPBottomNav(
        selectedItem: selectedItem,
        onItemTapped: onItemTapped,
        permitedList: permitedViews,
      ),
    );
  }
}
