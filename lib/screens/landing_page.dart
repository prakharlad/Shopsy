// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/firebase_services/firebase_shopsy.dart';
import 'package:shopsy/screens/home_page.dart';
import 'package:shopsy/screens/login_page.dart';
import 'package:shopsy/shared/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final Future<FirebaseApp>? _initialisation;

  @override
  void initState() {
    _initialisation = FirebaseShopsy().shopsyInitialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialisation,
        builder: (context, snapshot) {
          // if snapshot has error
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Error : ${snapshot.error}",
                  style: Constants.regularHeading,
                ),
              ),
            );
          }

          // if app initialiasation is done
          if (snapshot.connectionState == ConnectionState.done) {
            //  checking user authentication
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, streamSnapshot) {
                //  if there is error
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "Error : ${snapshot.error}",
                        style: Constants.regularHeading,
                      ),
                    ),
                  );
                }

                // connection state active - Do the user login check inside the if statement
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  var _user = streamSnapshot.data;

                  // if user is not logged in -show login page
                  if (_user == null) {
                    return LoginPage();
                  } else {
                    // user logged in -show home page
                    return HomePage();
                  }
                }

                //  checking authentication
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "checking Authentication....",
                          style: Constants.regularHeading,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "App intializing ....",
                    style: Constants.regularHeading,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
