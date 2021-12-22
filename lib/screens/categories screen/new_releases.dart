import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/shared/constants.dart';

class NewReleases extends StatelessWidget {
  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  UserDetails userDetails = UserDetails();

  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  User? _user = FirebaseAuth.instance.currentUser;

  NewReleases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future:
                  _productRef.doc("Categories").collection("NewReleases").get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: ListView(
                        padding: EdgeInsets.only(
                          top: 80.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                      categoryRef: "NewReleases",
                                      productid: document.id,
                                      isBookmark: false),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.8),
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
                                      height: 140.0,
                                      width: 130.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.network(
                                          "${document['images'][0]}",
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
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 5.0,
                                                  top: 5.0),
                                              height: 50.0,
                                              width: 230.0,
                                              child: Text(
                                                "${document['name']}",
                                                style:
                                                    Constants.regularBoldText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 4.0,
                                            left: 5.0,
                                          ),
                                          height: 30.0,
                                          // color: Colors.red,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            document['author'],
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 10.0,
                                            left: 5.0,
                                            top: 5.0,
                                          ),
                                          height: 30.0,
                                          width: 250.0,
                                          // color: Colors.white,
                                          child: Text(
                                            "Rs. ${document['price']}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: CustomActionBar(
              hasBackArrow: true,
              hasSave: false,
              hasCart: true,
              hasBackBtnAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              hasBackGround: true,
              hasEditAction: false,
              hasTitle: true,
              title: "New Releases",
              isLoading: false,
            ),
          )
        ],
      ),
    );
  }
}
