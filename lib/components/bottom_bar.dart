// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors_in_immutables, deprecated_member_use, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomTabs extends StatefulWidget {
  final int? selectedTabs;
  final Function(int)? tabPressed;
  BottomTabs({this.selectedTabs, this.tabPressed});
  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTabs ?? 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavBtn(
            faicons: FontAwesomeIcons.home,
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed!(0);
            },
          ),
          BottomNavBtn(
            faicons: FontAwesomeIcons.search,
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed!(1);
            },
          ),
          BottomNavBtn(
            faicons: FontAwesomeIcons.solidBookmark,
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed!(2);
            },
          ),
          BottomNavBtn(
            faicons: FontAwesomeIcons.userCog,
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabPressed!(3);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavBtn extends StatelessWidget {
  final IconData? faicons;
  final bool? selected;
  final Function()? onPressed;
  BottomNavBtn({this.selected, this.faicons, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected
                  ? Colors.deepOrange.shade900
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Icon(faicons,
            color: _selected ? Colors.deepOrange.shade900 : Colors.black),
      ),
    );
  }
}
