// ignore_for_file: prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:shopsy/components/category_widget.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/components/custom_type.dart';
import 'package:shopsy/screens/chatbot.dart';

class HomeS extends StatefulWidget {

  HomeS({Key? key}) : super(key: key);

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  int? selectedTab;
  Widget? myWidget;

  @override
  void initState() {
    selectedTab = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              top: 170.0,
              bottom: 20.0,
              left: 20.0,
            ),
            children: [
              Container(
                child: Text(
                  'Romantic',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Romantic',
                navigate: "Romantic",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Crime',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Crime',
                navigate: "Crime",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Autobiography',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Autobiography',
                navigate: "Autobiography",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Fictional',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Fictional',
                navigate: "Fictional",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Historical',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Historical',
                navigate: "Historical",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Mythological',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Mythological',
                navigate: "Mythological",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'New Releases',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'NewReleases',
                navigate: "NewReleases",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Popular Authors',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'PopularAuthors',
                navigate: "PopularAuthors",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Political',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Political',
                navigate: "Political",
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2.0,
                endIndent: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'Bestsellers',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CategoryWidget(
                categoryRef: 'Bestseller',
                navigate: "Bestseller",
              ),
            ],
          ),
          Positioned(
            // left: MediaQuery.of(context).size.width - 60.0,
            bottom: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBot(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 60.0,
                width: 60.0,
                child: Icon(
                  Icons.message,
                  size: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                child: CustomActionBar(
                  hasBackArrow: false,
                  hasBackGround: true,
                  hasEditAction: false,
                  hasSave: false,
                  isLoading: false,
                  hasCart: true,
                  title: "Home",
                  hasTitle: true,
                  hasBackBtnAction: false,
                ),
              ),
              CustomType(
                onPressed: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                  print("home page selected tab ${selectedTab}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
