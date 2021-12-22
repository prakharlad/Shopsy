// ignore_for_file: dead_code, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/shared/constants.dart';

class MyOrders extends StatefulWidget {
  // String productid;
  // String categoryRef;
  UserDetails userDetails = UserDetails();
  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  User? _user = FirebaseAuth.instance.currentUser;
  UserDetails _userDetails = UserDetails();

  MyOrders({
    Key? key,
    // required this.productid,
    // required this.categoryRef,
  }) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // Future _addToOrder() async {
  //   return await widget._userRef
  //       .doc(widget._user!.uid)
  //       .collection("Orders")
  //       .doc(widget.productid)
  //       .set({
  //     "coverType": widget.userDetails.typeOfCover,
  //     "productid": widget.productid,
  //     "categoryRef": widget.categoryRef,
  //   });
  // }

  Future _deleteFromOrder(var productId) async {
    await widget._userRef
        .doc(widget._user!.uid)
        .collection("Orders")
        .doc(productId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order cancelled'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: widget._userRef
              .doc(widget._user!.uid)
              .collection("Orders")
              .snapshots(),
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
                  Map<String, dynamic> _documentBookmarkData = document.data();
                  widget._userDetails.typeOfCover =
                      _documentBookmarkData['coverType'];

                  return GestureDetector(
                    onTap: () {
                      print('cover type ${widget._userDetails.typeOfCover}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                productid: document.id,
                                categoryRef:
                                    _documentBookmarkData['categoryRef'],
                                isBookmark: false)),
                      );
                    },
                    child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: widget._productRef
                            .doc('Categories')
                            .collection(_documentBookmarkData['categoryRef'])
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
                                      color:
                                          Colors.grey.shade100.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12.0),
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
                                                  BorderRadius.circular(10.0)),
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
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 5.0,
                                                  top: 15.0),
                                              height: 70.0,
                                              width: 230.0,
                                              child: Text(
                                                "${_productMap['name']}",
                                                style:
                                                    Constants.regularBoldText,
                                              ),
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
                                                "${_documentBookmarkData['coverType']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await _deleteFromOrder(
                                                      document.id,
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons.close,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          'Cancel Order',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
          title: "My Orders",
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
    )));
  }
}
