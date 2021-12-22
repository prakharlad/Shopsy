// ignore_for_file: must_be_immutable, prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/screens/cart_page.dart';
import 'package:shopsy/shared/constants.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasCart;
  final bool? hasBackGround;
  final bool? hasBackBtnAction;
  final bool? hasEditAction;
  Function()? onPressed;
  final bool? hasSave;
  Function()? onSaveBtnPressed;
  final bool? isLoading;

  CustomActionBar(
      {Key? key,
      this.title,
      this.isLoading,
      this.hasSave,
      this.hasEditAction,
      this.hasBackBtnAction,
      this.hasBackGround,
      this.hasBackArrow,
      this.hasTitle,
      this.onSaveBtnPressed,
      this.onPressed,
      this.hasCart})
      : super(key: key);
  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasCart = hasCart ?? true;

    bool _hasEditAction = hasEditAction ?? false;
    bool _hasBackground = hasBackGround ?? true;
    bool _hasSave = hasSave ?? false;
    bool _isLoading = isLoading ?? false;


    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground
            ? LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0)],
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
              )
            : null,
      ),
      padding: EdgeInsets.only(
        top: 35.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: onPressed,
              child: Container(
                height: 42.0,
                width: 42.0,
                margin: EdgeInsets.only(right: 20.0),
                child: Image(image: AssetImage("assets/images/back.png")),
              ),
            ),
          if (_hasTitle)
            Expanded(
              flex: 5,
              child: Container(
                alignment: _hasBackArrow && _hasCart
                    ? Alignment.center
                    : Alignment.centerLeft,
                // width: 100.0,
                height: 42.0,
                // color: Colors.redAccent,
                child: Text(
                  title ?? "Action Bar",
                  style: Constants.boldHeading,
                  // TextStyle(
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: 30.0,
                  // ),
                ),
              ),
            ),
          if (_hasEditAction)
            GestureDetector(
              onTap: onSaveBtnPressed,
              child: Container(
                width: 42.0,
                height: 42.0,
                padding: EdgeInsets.all(2.0),
                child: Image.asset('assets/images/edit.png',
                    color: Theme.of(context).primaryColor),
              ),
            ),
          if (_hasSave)
            GestureDetector(
              onTap: onSaveBtnPressed,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.red,
                width: 60.0,
                height: 42.0,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        ' Save ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent.shade700,
                        ),
                      ),
              ),
            ),

          if (_hasCart)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              child:
                  // Container(
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     color: Colors.black,
                  //   ),
                  //   width: 42.0,
                  //   height: 42.0,
                  //   child:
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: _userRef
                          .doc(_user!.uid)
                          .collection("Cart")
                          .snapshots(),
                      builder: (context, snapshot) {
                        int _totalItems = 0;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                              _documents = snapshot.data?.docs;
                          _totalItems = _documents!.length;
                        }
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: _totalItems > 0
                                ? Colors.redAccent.shade700
                                : Colors.black,
                          ),
                          width: 42.0,
                          height: 42.0,
                          child: Text(
                            "${_totalItems}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
            ),
          // ),
        ],
      ),
    );
  }
}
