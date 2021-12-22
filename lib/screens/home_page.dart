// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/bottom_bar.dart';
import 'package:shopsy/screens/bookmark_page.dart';
import 'package:shopsy/screens/chatbot.dart';
import 'package:shopsy/tabs/home_s.dart';
import 'package:shopsy/tabs/home_screen.dart';
import 'package:shopsy/tabs/saved_screen.dart';
import 'package:shopsy/tabs/search_screen.dart';
import 'package:shopsy/tabs/settings_screen.dart';
// import 'package:shopsy/shared/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int? _selectedTab = 0;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeS(),
                  SearchScreen(),
                  // SavedScreen(),
                  BookmarkPage(),
                  SettingsScreen(),
                ],
              ),
            ),
            // Text("hiii"),
            BottomTabs(
              selectedTabs: _selectedTab,
              tabPressed: (pageno) {
                _pageController!.animateToPage(
                  pageno,
                  duration: Duration(milliseconds: 5),
                  curve: Curves.easeOutCubic,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

  // TextButton(
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut();
              //   },
              //   child: const Text(
              //     "Sign out",
              //     style: Constants.regularHeading,
              //   ),
              // ),
