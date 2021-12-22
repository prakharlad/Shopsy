import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/components/custom_input.dart';
import 'package:shopsy/components/custom_input_controller.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/screens/home_page.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/shared/constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection("Products");

  UserDetails userDetails = UserDetails();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    // _searchString = "";
    return Container(
      child: Stack(
        children: [
          _searchString.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 130.0,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 30.0,
                      child: Text(
                        "Search Results",
                        style: Constants.regularBoldText,
                      ),
                    ),
                  ),
                )
              : FutureBuilder<QuerySnapshot>(
                  future: _productRef
                      .doc("Categories")
                      .collection("Mythological")
                      .orderBy('search_string')
                      .startAt([_searchString]).endAt(
                          ["$_searchString\uf8ff"]).get(),
                  // future: _productRef.orderBy('search_string').startAt(
                  //     [_searchString]).endAt(["$_searchString\uf8ff"]).get(),  
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
                        // scrollDirection: Axis.vertical,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 0.5,
                        // ),
                        padding: EdgeInsets.only(
                          top: 150.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ProductPage(
                                    categoryRef: "Mythological",
                                    productid: document.id,
                                    isBookmark: userDetails.isBookmarked,
                                  );
                                }),
                              );
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
                                              document['name'] ??
                                                  "Product Name",
                                              style:
                                                  Constants.productNameHeading,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Rs. ${document['price']}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CustomInput(
              pwdField: false,
              showText: " Search ",
              onSubmit: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                  print('search string ${_searchString}');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   _searchString = "";
  //   super.dispose();
  // }
}
      // CustomActionBar(
          //   hasBackArrow: true,
          //   title: "Search",
          //   hasTitle: true,
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HomePage(),
          //       ),
          // );
          // },
          // ),
    