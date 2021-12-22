// ignore_for_file: use_key_in_widget_constructors, empty_constructor_bodies, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/cart_page.dart';
import 'package:shopsy/screens/edit_profile_page.dart';
import 'package:shopsy/screens/home_page.dart';
import 'package:shopsy/screens/my_orders.dart';
import 'package:shopsy/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection('User');

  User? _user = FirebaseAuth.instance.currentUser;
  UserDetails userDetails = UserDetails();
  Constants constants = Constants();
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: _userRef.doc(_user!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error :${snapshot.error}'),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  var _userData = snapshot.data;

                  userDetails.firstName = _userData!['first name'];
                  userDetails.lastName = _userData['last name'];
                  userDetails.gender = _userData['gender'];
                  userDetails.age = _userData['age'];
                  userDetails.email = _userData['email'];
                  userDetails.mobileNumber = _userData['mobile number'];
                  // print('user data ${_userData}');
                  return ListView(
                    padding: const EdgeInsets.only(
                        top: 80.0, left: 30.0, right: 30.0, bottom: 30.0),
                    children: [
                      Column(
                        //  padding: const EdgeInsets.only(
                        // top: 80.0, left: 30.0, right: 30.0, bottom: 30.0),

                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60.0,
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              // borderRadius: BorderRadius.circular(150.0),
                              foregroundImage:
                                  AssetImage('assets/images/profile.png'),
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 5.0,
                            child: Divider(
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5.0,
                            ),
                            child: Text(
                              "First Name",
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.firstName}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Last Name',
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.lastName}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Gender',
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.gender}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Age',
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.age}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Mobile',
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.mobileNumber}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Email',
                              style: Constants.regularText,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: Text(
                              "${userDetails.email}",
                              style: constants.KdescBlurText,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 5.0,
                            child: Divider(
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "My Cart",
                                    style: Constants.regularText,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.shopping_cart_outlined),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 5.0,
                            child: Divider(
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyOrders(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "My Orders",
                                    style: Constants.regularText,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Image.asset(
                                    'assets/images/order.png',
                                    height: 25.0,
                                    width: 25.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 5.0,
                            child: Divider(
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Sign Out",
                                    style: Constants.regularText,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.logout),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasBackArrow: true,
            hasBackBtnAction: true,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            onSaveBtnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    firstName: userDetails.firstName,
                    lastName: userDetails.lastName,
                    gender: userDetails.gender,
                    age: userDetails.age,
                    mobileNumber: userDetails.mobileNumber,
                    email: userDetails.email,
                  ),
                ),
              );
            },
            hasBackGround: false,
            hasEditAction: true,
            title: "Settings",
            hasTitle: true,
            hasCart: false,
          ),
        ],
      ),
    );
  }
}
