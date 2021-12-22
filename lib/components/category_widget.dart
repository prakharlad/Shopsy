// ignore_for_file: must_be_immutable, prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/screens/categories%20screen/autobiography.dart';
import 'package:shopsy/screens/categories%20screen/bestsellers.dart';
import 'package:shopsy/screens/categories%20screen/crime.dart';
import 'package:shopsy/screens/categories%20screen/fictional.dart';
import 'package:shopsy/screens/categories%20screen/historical.dart';
import 'package:shopsy/screens/home_page.dart';
import 'package:shopsy/screens/categories%20screen/mythological.dart';
import 'package:shopsy/screens/categories%20screen/new_releases.dart';
import 'package:shopsy/screens/categories%20screen/political.dart';
import 'package:shopsy/screens/categories%20screen/popular_authors.dart';
import 'package:shopsy/screens/product_page.dart';
import 'package:shopsy/screens/categories%20screen/romantic.dart';

class CategoryWidget extends StatefulWidget {
  final String categoryRef;
  final String navigate;
  CollectionReference<Map<String, dynamic>> _productRef =
      FirebaseFirestore.instance.collection('Products');
  CategoryWidget({Key? key, required this.categoryRef, required this.navigate})
      : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: widget._productRef
            .doc('Category')
            .collection(widget.categoryRef)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: snapshot.data!.docs.map((document) {
                      Map<String, dynamic> data = document.data();
                      // // return Container(
                      //   height: 100.0,
                      //   width: 100.0,
                      //   margin: EdgeInsets.all(10.0),
                      //   child: Text("${l}"),
                      //   color: Colors.red);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productid: document.id,
                                categoryRef: widget.categoryRef,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 15.0,
                            right: 20.0,
                            bottom: 15.0,
                          ),
                          height: 190.0,
                          width: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  data['images'][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  width: 220.0,
                                  height: 190.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.5),
                                        Colors.white.withOpacity(0),
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 100.0,
                                      top: 20.0,
                                    ),
                                    width: 50,
                                    // height: 50,
                                    // color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 10.0,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data['name'],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data['author'],
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Rs. ${data['price']}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            if (widget.navigate == "Crime") {
                              return Crime();
                            }
                            if (widget.navigate == "Romantic") {
                              return Romantic();
                            }
                            if (widget.navigate == "Fictional") {
                              return Fictional();
                            }
                            if (widget.navigate == "Bestseller") {
                              return BestSellers();
                            }
                            if (widget.navigate == "PopularAuthors") {
                              return PopularAuthors();
                            }
                            if (widget.navigate == "Autobiography") {
                              return Autobiography();
                            }
                            if (widget.navigate == "Historical") {
                              return Historical();
                            }
                            if (widget.navigate == "Mythological") {
                              return Mythological();
                            }
                            if (widget.navigate == "Political") {
                              return Political();
                            }
                            if (widget.navigate == "NewReleases") {
                              return NewReleases();
                            }

                            return HomePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            // height: 60.0,
                            // width: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              // color: Colors.teal,
                            ),
                            child: Icon(
                              Icons.arrow_right_alt,
                              size: 50.0,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'See More',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
