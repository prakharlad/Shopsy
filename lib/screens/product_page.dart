// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/components/image_swipe.dart';
import 'package:shopsy/components/type_of_cover.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/shared/constants.dart';

class ProductPage extends StatefulWidget {
  String productid;
  String categoryRef;
  bool? isBookmark;
  ProductPage(
      {Key? key,
      required this.productid,
      required this.categoryRef,
      this.isBookmark})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  UserDetails userDetails = UserDetails();

  User? _user = FirebaseAuth.instance.currentUser;
  var _selectedCoverType;

  Future _addToCart() async {
    return await _userRef
        .doc(_user!.uid)
        .collection("Cart")
        .doc(widget.productid)
        .set({
      "coverType": userDetails.typeOfCover,
      "productid": widget.productid,
      "categoryRef": widget.categoryRef,
    });
  }

  Future _addToBookmark() async {
    return await _userRef
        .doc(_user!.uid)
        .collection("Bookmark")
        .doc(widget.productid)
        .set({
      "isbookmarked": true,
      "productid": widget.productid,
      "coverType": userDetails.typeOfCover,
      "categoryRef": widget.categoryRef,
    });
  }

  Future _deleteFromBookmark() async {
    return await _userRef
        .doc(_user!.uid)
        .collection("Bookmark")
        .doc(widget.productid)
        .delete();
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the Cart"),
  );

  @override
  Widget build(BuildContext context) {
    bool _isBookmarked = false;
    print(_isBookmarked);
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _productRef
                .doc("Categories")
                .collection(widget.categoryRef)
                .doc(widget.productid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error : ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.active) {
                var documentData = snapshot.data?.data();
                List imagesList = documentData?['images'];
                List typeOfCover = documentData?['type'];
                String desc = documentData?['desc'];

                return SafeArea(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        height: 300.0,
                        child: Image.network(
                          imagesList[0],
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                documentData!['name'],
                                style: Constants.boldHeading,
                              ),
                            ),
                            Text(
                              "Rs.  ${documentData['price']}",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          // "Rs.  ${snapshot.data?.data()?['price']}",
                          documentData['author'],
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: ReadMoreText(
                          desc,
                          trimLines: 3,
                          textAlign: TextAlign.justify,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Show More ",
                          trimExpandedText: " Show Less ",
                          lessStyle: TextStyle(
                            color: Colors.blueAccent.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          moreStyle: TextStyle(
                            color: Colors.blueAccent.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Cover Type",
                          style: Constants.regularBoldText,
                        ),
                      ),
                      TypeOfcover(
                        typeOfCover: typeOfCover,
                        onSelected: (coverType) {
                          userDetails.typeOfCover = coverType;
                        },
                        productId: widget.productid,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 24.0,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  userDetails.isBookmarked =
                                      !(userDetails.isBookmarked);
                                });

                                bool? actionType = userDetails.isBookmarked;
                                if (actionType == true) await _addToBookmark();
                                if (actionType == false)
                                  await _deleteFromBookmark();
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(9.0),
                                child: StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: _userRef
                                        .doc(_user!.uid)
                                        .collection("Bookmark")
                                        .doc(widget.productid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        Map<String, dynamic>? details =
                                            snapshot.data!.data();

                                        try {
                                          _isBookmarked =
                                              details!['isbookmarked'];

                                          userDetails.isBookmarked =
                                              details['isbookmarked'];
                                        } catch (e) {
                                          print(e);

                                          _isBookmarked =
                                              userDetails.isBookmarked;
                                        }
                                      }
                                      return Image.asset(
                                        "assets/images/bookmark.png",
                                        color: _isBookmarked
                                            ? Colors.red
                                            : Colors.black,
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () async {
                                  await _addToCart();
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.all(9.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 9.0),
                                        child: Image.asset(
                                          "assets/images/add_to_cart.png",
                                        ),
                                      ),
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
//             builder: (context, snapshot) {
//               var documentData = snapshot.data?.data();
//               List imagesList = documentData?['images'];
//               List typeOfCover = documentData?['type'];

// // _isBookmarked =
//               if (snapshot.hasError) {
//                 return Scaffold(
//                   body: Center(
//                     child: Text("Error : ${snapshot.error}"),
//                   ),
//                 );
//               }

//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   String desc = documentData?['desc'];

//                   return SafeArea(
//                     child: ListView(
//                       padding: EdgeInsets.all(0),
//                       children: [
//                         ImageSwipe(imagesList: imagesList),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 8.0,
            //     horizontal: 24.0,
            //   ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "${snapshot.data?.data()?['name']}",
//                                   style: Constants.boldHeading,
//                                 ),
//                               ),
//                               Text(
//                                 "Rs.  ${snapshot.data?.data()?['price']}",
//                                 style: TextStyle(
//                                     fontSize: 20.0,
//                                     color: Theme.of(context).primaryColor,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 8.0,
//                             horizontal: 24.0,
//                           ),
//                           child: Text(
//                             // "Rs.  ${snapshot.data?.data()?['price']}",
//                             "Author",
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Colors.black.withOpacity(0.6),
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 8.0,
//                             horizontal: 24.0,
//                           ),
//                           child:
//                               // Text(
//                               //   "${desc}" ?? "Description",
//                               //   style: TextStyle(
//                               //     fontSize: 18.0,
//                               //   ),
//                               // ),

//                               ReadMoreText(
//                             desc,
//                             trimLines: 3,
//                             textAlign: TextAlign.justify,
//                             trimMode: TrimMode.Line,
//                             trimCollapsedText: " Show More ",
//                             trimExpandedText: " Show Less ",
//                             lessStyle: TextStyle(
//                               color: Colors.blueAccent.shade700,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                             ),
//                             moreStyle: TextStyle(
//                               color: Colors.blueAccent.shade700,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                             ),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 24.0,
//                             horizontal: 24.0,
//                           ),
//                           child: Text(
//                             "Cover Type",
//                             style: Constants.regularBoldText,
//                           ),
//                         ),
//                         TypeOfcover(
//                           typeOfCover: typeOfCover,
//                           onSelected: (coverType) {
//                             userDetails.typeOfCover = coverType;
//                           },
//                           productId: widget.productid,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 24.0,
//                             horizontal: 24.0,
//                           ),
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () async {
//                                   setState(() {
//                                     userDetails.isBookmarked =
//                                         !(userDetails.isBookmarked);
//                                   });

//                                   bool? actionType = userDetails.isBookmarked;
//                                   if (actionType == true)
//                                     await _addToBookmark();
//                                   if (actionType == false)
//                                     await _deleteFromBookmark();
//                                 },
//                                 child: Container(
//                                   width: 50.0,
//                                   height: 50.0,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.withOpacity(0.4),
//                                     borderRadius: BorderRadius.circular(12.0),
//                                   ),
//                                   padding: EdgeInsets.all(9.0),
//                                   child: StreamBuilder<
//                                           DocumentSnapshot<
//                                               Map<String, dynamic>>>(
//                                       stream: _userRef
//                                           .doc(_user!.uid)
//                                           .collection("Bookmark")
//                                           .doc(widget.productid)
//                                           .snapshots(),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.active) {
//                                           Map<String, dynamic>? details =
//                                               snapshot.data!.data();

//                                           try {
//                                             _isBookmarked =
//                                                 details!['isbookmarked'];

//                                             userDetails.isBookmarked =
//                                                 details['isbookmarked'];
//                                           } catch (e) {
//                                             print(e);

//                                             _isBookmarked =
//                                                 userDetails.isBookmarked;
//                                           }
//                                         }
//                                         return Image.asset(
//                                           "assets/images/bookmark.png",
//                                           color: _isBookmarked
//                                               ? Colors.red
//                                               : Colors.black,
//                                         );
//                                       }),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 40.0,
//                               ),
//                               Expanded(
//                                 flex: 5,
//                                 child: InkWell(
//                                   onTap: () async {
//                                     await _addToCart();
//                                     // ignore: deprecated_member_use
//                                     Scaffold.of(context)
//                                         .showSnackBar(_snackBar);
//                                   },
//                                   child: Container(
//                                     width: 50.0,
//                                     height: 50.0,
//                                     decoration: BoxDecoration(
//                                       color: Colors.blueAccent,
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     padding: const EdgeInsets.all(9.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 1.0, horizontal: 9.0),
//                                           child: Image.asset(
//                                             "assets/images/add_to_cart.png",
//                                           ),
//                                         ),
//                                         Text(
//                                           "Add to Cart",
//                                           style: TextStyle(
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );

//                   // Center(child: Text(snapshot.data?.data()?['name']));
//                 }
//               }

//               return Center(child: CircularProgressIndicator());
            // },
          ),
          CustomActionBar(
            hasTitle: false,
            hasCart: true,
            hasBackArrow: true,
            hasBackBtnAction: true,
            hasBackGround: false,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
