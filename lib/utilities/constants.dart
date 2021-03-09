import 'package:flutter/material.dart';
import 'package:mealprepapp/screens/product_screen.dart';
import 'package:mealprepapp/screens/user_screen.dart';

const String kURLApi = bool.fromEnvironment('dart.vm.product')
    ? "https://us-central1-mealprep-13a67.cloudfunctions.net/api"
    : "http://10.0.2.2:3001";

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  filled: true,
  fillColor: Colors.white,
  focusColor: Colors.white,
  hintStyle: TextStyle(color: Colors.lightGreen),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

final List<Map> kViews = [
  {
    "widget": ProductScreen(),
    "icon": Icons.fastfood,
    "text": "Productos",
    "id": 0,
  },
  {
    "widget": UserScreen(),
    "icon": Icons.supervised_user_circle,
    "text": "Usuarios",
    "role": ["admin", "moderator"],
    "id": 1,
  },
  {
    "widget": UserScreen(),
    "icon": Icons.supervised_user_circle,
    "text": "Prueba",
    "id": 2,
  },
];

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Agrega un valor...',
);
