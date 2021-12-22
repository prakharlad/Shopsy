// ignore_for_file: prefer_const_constructors, unused_field
// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:readmore/readmore.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/my_orders.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/shared/constants.dart';
import 'package:shopsy/tabs/saved_screen.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  CartPage({
    Key? key,
  }) : super(key: key);

  // var productId ;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  UserDetails userDetails = UserDetails();
  String? productId;
  String? categoryRef;
  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  User? _user = FirebaseAuth.instance.currentUser;
  UserDetails _userDetails = UserDetails();

  Future _deleteFromCart(var productId) async {
    return await _userRef
        .doc(_user!.uid)
        .collection("Cart")
        .doc(productId)
        .delete();
  }

  Future _addToOrder(var productId, var categoryRef) async {
    return await _userRef
        .doc(_user!.uid)
        .collection("Orders")
        .doc(productId)
        .set({
      "coverType": userDetails.typeOfCover,
      "productid": productId,
      "categoryRef": categoryRef,
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? paymentIntentData;

    Future<void> displayPaymentSheet() async {
      try {
        await Stripe.instance.presentPaymentSheet(
            parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['paymentIntent'],
          confirmPayment: true,
        ));
        setState(() {
          paymentIntentData = null;
        });
        _addToOrder(productId, categoryRef);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Paid Successfully'),
          ),
        );
        _deleteFromCart(productId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyOrders(
                // productid: productId!,
                // categoryRef: categoryRef!,
                ),
          ),
        );
      } catch (e) {
        print(e);
      }
    }

    Future<void> makePayment() async {
      final url = Uri.parse(
          'https://us-central1-shopsy-a8662.cloudfunctions.net/shopsy_pay');
      final response =
          await http.get(url, headers: {'Content-type': 'application/json'});
      paymentIntentData = json.decode(response.body);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
              applePay: true,
              googlePay: true,
              style: ThemeMode.light,
              merchantCountryCode: 'IN',
              merchantDisplayName: 'Stripe-Test-User'));
      setState(() {
        displayPaymentSheet();
      });
    }

    return SafeArea(
      child: Scaffold(
          body: Container(
              child: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _userRef.doc(_user!.uid).collection("Cart").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              }

              if (snapshot.connectionState == ConnectionState.active) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    // var productId =document.id;
                    Map<String, dynamic> documentBookmarkData = document.data();
                    _userDetails.typeOfCover =
                        documentBookmarkData['coverType'];

                    return GestureDetector(
                      onTap: () {
                        print('cover type ${_userDetails.typeOfCover}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  productid: document.id,
                                  categoryRef:
                                      documentBookmarkData['categoryRef'],
                                  isBookmark: false)),
                        );
                      },
                      child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: _productRef
                              .doc('Categories')
                              .collection(documentBookmarkData['categoryRef'])
                              .doc(document.id)
                              .snapshots(),
                          builder: (context, prodSnapshot) {
                            if (prodSnapshot.hasError) {
                              return Scaffold(
                                body: Center(
                                  child: Text("Error : ${prodSnapshot.error}"),
                                ),
                              );
                            }
                            if (prodSnapshot.connectionState ==
                                ConnectionState.active) {
                              Map<String, dynamic>? _productMap =
                                  prodSnapshot.data!.data();
                              String desc = _productMap!['desc'];
                              return Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100
                                            .withOpacity(0.9),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200
                                                .withOpacity(0.8),
                                            offset: Offset(0.0, 3.0),
                                            spreadRadius: 0.3,
                                            blurRadius: 5.0,
                                          )
                                        ]),
                                    margin: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 150.0,
                                            width: 150.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: Image.network(
                                                "${_productMap['images'][0]}",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: EdgeInsets.only(
                                                        right: 10.0,
                                                        left: 5.0,
                                                        top: 15.0),
                                                    height: 50.0,
                                                    width: 170.0,
                                                    child: Text(
                                                      "${_productMap['name']}",
                                                      style: Constants
                                                          .regularBoldText,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await _deleteFromCart(
                                                          document.id);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      height: 50.0,
                                                      width: 50.0,
                                                      child: Center(
                                                        child: Image.asset(
                                                          'assets/images/delete_cart.png',
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //     right: 10.0,
                                              //     left: 5.0,
                                              //     // top: 5.0,
                                              //   ),
                                              //   // color: Colors.blue,
                                              //   height: 50.0,
                                              //   width: 250.0,
                                              //   child: Text(
                                              //     desc,
                                              //     maxLines: 2,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     style: TextStyle(
                                              //       color: Colors.black
                                              //           .withOpacity(0.5),
                                              //       fontSize: 15.0,
                                              //     ),
                                              //   ),
                                              // ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 5.0,
                                                  // top: 5.0,
                                                ),
                                                // color: Colors.white,
                                                height: 30.0,
                                                width: 250.0,
                                                child: Text(
                                                  "${documentBookmarkData['coverType']}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 10.0,
                                                      left: 5.0,
                                                      // top: 5.0,
                                                    ),
                                                    height: 30.0,
                                                    // width: 250.0,
                                                    // color: Colors.white,
                                                    child: Text(
                                                      "Rs. ${_productMap['price']}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        productId = document.id;
                                                        categoryRef =
                                                            documentBookmarkData[
                                                                'categoryRef'];

                                                        makePayment();
                                                        // await _addToOrder(
                                                        //     document.id,
                                                        //     documentBookmarkData[
                                                        //         'categoryRef']);
                                                      },
                                                      child: Text("Pay"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }
                            return Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }),
                    );
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasCart: true,
            hasBackArrow: true,
            hasBackGround: true,
            hasTitle: true,
            onPressed: () {
              Navigator.pop(context);
            },
            title: "Cart",
          ),
          // Positioned(
          //   bottom: 10.0,
          //   top: MediaQuery.of(context).size.height - 80.0,
          //   left: MediaQuery.of(context).size.width / 2 - 50.0,
          //   child: Container(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         makePayment();
          //       },
          //       child: Text("Pay Amount"),
          //     ),
          //   ),
          // ),
        ],
      ))),
    );
  }
}
