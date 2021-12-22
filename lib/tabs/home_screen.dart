// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/firebase_services/firebase_shopsy.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/shared/constants.dart';

class HomeScreen extends StatelessWidget {
  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  UserDetails userDetails = UserDetails();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
            builder: (context, snapshot) {
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
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return ProductPage(

                        //       productid: document.id,
                        //       isBookmark: userDetails.isBookmarked,
                        //     );
                        //   }),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0)),
                        height: 400.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Stack(
                          children: [
                            Container(
                              width: 400.0,
                              child:
                                  //  Hero(
                                  // tag: 'bookImage',
                                  // child:
                                  ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  "${document['images'][0]}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              // ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    bottom: 15.0,
                                    top: 10.0),
                                height: 160.0,
                                width: 400.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0),
                                  ],
                                  begin: Alignment(0, 1),
                                  end: Alignment(0, 0),
                                )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        document['name'] ?? "Product Name",
                                        style: Constants.productNameHeading,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Rs. ${document['price']}",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text("Name : ${document['name']}"),
                      ),
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
            hasBackArrow: false,
            hasCart: true,
            title: "Home",
            hasTitle: true,
            hasBackBtnAction: false,
          )
        ],
      ),
    );
  }
}
