import 'package:flutter/material.dart';
import 'package:shopsy/screens/categories%20screen/autobiography.dart';
import 'package:shopsy/screens/categories%20screen/bestsellers.dart';
import 'package:shopsy/screens/categories%20screen/crime.dart';
import 'package:shopsy/screens/categories%20screen/fictional.dart';
import 'package:shopsy/screens/categories%20screen/historical.dart';
import 'package:shopsy/screens/categories%20screen/mythological.dart';
import 'package:shopsy/screens/categories%20screen/new_releases.dart';
import 'package:shopsy/screens/categories%20screen/political.dart';
import 'package:shopsy/screens/categories%20screen/popular_authors.dart';
import 'package:shopsy/screens/categories%20screen/romantic.dart';

class CustomType extends StatefulWidget {
  // final String? typeTitle;
  final Function(int)? onPressed;
  // final bool isPressed;
  // final Color? color;
  List<String> categories = [
    "Crime, Thriller and Mystery",
    "Romantic",
    "Fictional",
    "Mythological",
    "Historical",
    "Autobiography",
    "Political",
    "New Releases",
    "Popular Authors",
    "BestSellers",
  ];

  CustomType({
    Key? key,
    // this.color,
    // required this.isPressed,
    this.onPressed,
    // this.typeTitle,
  }) : super(key: key);

  @override
  State<CustomType> createState() => _CustomTypeState();
}

class _CustomTypeState extends State<CustomType> {
  int? selected;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool _isPressed = widget.isPressed ?? false;
    // String _typeTitle = widget.typeTitle ?? "Type";

    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.3)],
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
        ),
        color: Colors.red,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < widget.categories.length; i++)
              GestureDetector(
                onTap: () {
                  widget.onPressed!(i);
                  setState(() {
                    selected = i;
                  });
                  if (selected == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Crime(),
                      ),
                    );
                  }
                  if (selected == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Romantic(),
                      ),
                    );
                  }
                  if (selected == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fictional(),
                      ),
                    );
                  }
                  if (selected == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Mythological(),
                      ),
                    );
                  }
                  if (selected == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Historical(),
                      ),
                    );
                  }
                  if (selected == 5) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Autobiography(),
                      ),
                    );
                  }
                  if (selected == 6) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Political(),
                      ),
                    );
                  }

                  if (selected == 7) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewReleases(),
                      ),
                    );
                  }

                  if (selected == 8) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularAuthors(),
                      ),
                    );
                  }

                  if (selected == 9) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BestSellers(),
                      ),
                    );
                  }
                  print("selected ${selected}");
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: selected == i
                          ? Colors.lightBlueAccent
                          : Colors.transparent,
                      width: 5.0,
                      style: BorderStyle.solid,
                    ),
                  )),
                  child: Text(
                    widget.categories[i],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color:
                          selected == i ? Colors.lightBlueAccent : Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       _isPressed = true;
    //     });
    //     print(_isPressed);
    //   },
    //   child: Container(
    //     margin: EdgeInsets.only(
    //       left: 10.0,
    //       right: 10.0,
    //     ),
    //     child: Text(
    //       "Crime, Thriller and Mystery",
    //       style: TextStyle(
    //         fontSize: 16.0,
    //         color: _isPressed ? Colors.lightBlueAccent : Colors.black,
    //       ),
    //     ),
    //   ),
    // );
  }
}
