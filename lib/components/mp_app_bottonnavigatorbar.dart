import 'package:flutter/material.dart';

class MPBottomNav extends StatelessWidget {
  final int selectedItem;
  final Function onItemTapped;
  final List<Map> permitedList;
  MPBottomNav({this.selectedItem, this.onItemTapped, this.permitedList});

  List<BottomNavigationBarItem> renderList() {
    List<BottomNavigationBarItem> auxBtnBarItem = [];
    for (Map i in permitedList) {
      auxBtnBarItem.add(
        BottomNavigationBarItem(
          title: Text(i["text"]),
          icon: Icon(i["icon"]),
        ),
      );
    }
    return auxBtnBarItem;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: renderList(),
      currentIndex: selectedItem,
      selectedItemColor: Colors.blueGrey[900],
      onTap: (index) {
        onItemTapped(index);
      },
    );
  }
}
