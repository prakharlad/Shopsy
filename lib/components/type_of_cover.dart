import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/model/user_model.dart';

class TypeOfcover extends StatefulWidget {
  final List typeOfCover;
  final Function(String)? onSelected;
  final productId;

  TypeOfcover(
      {Key? key, this.onSelected, this.productId, required this.typeOfCover})
      : super(key: key);

  @override
  _TypeOfcoverState createState() => _TypeOfcoverState();
}

class _TypeOfcoverState extends State<TypeOfcover> {
  int? _selectedTab;
  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection("User");

  User? _user = FirebaseAuth.instance.currentUser;
  UserDetails _userDetails = UserDetails();

  @override
  void initState() {
    setState(() {
      _selectedTab = OurStream();
    });
    print("selected ${_selectedTab}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.typeOfCover.length; i++)
          GestureDetector(
            onTap: () {
              // print('selected ${_bookmarkData}');
              print('selected tab tab ${_selectedTab}');

              setState(() {
                _selectedTab = i;
                print('selected tab tab ${_selectedTab}');
              });
              widget.onSelected!("${widget.typeOfCover[i]}");
            },
            child: Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 42.0,
              decoration: BoxDecoration(
                // border: Border.all(
                //   width: 2.0,
                //   color: _selectedTab == i ? Colors.blueAccent : Colors.black,
                // ),
                borderRadius: BorderRadius.circular(20.0),
                color: _selectedTab == i
                    ? Colors.blueAccent
                    : Colors.grey.withOpacity(0.4),
              ),
              margin: EdgeInsets.only(bottom: 24.0, right: 24.0, left: 24.0),
              child: Text(
                "${widget.typeOfCover[i]}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
      ],
    );
  }

  int OurStream() {
    int _selectedTab = 0;

    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _userRef
            .doc(_user!.uid)
            .collection("Bookmark")
            .doc(widget.productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            Map<String, dynamic>? bookmarkData;
            String coverTypeSelected;
            int index;
            try {
              bookmarkData = snapshot.data!.data();
              coverTypeSelected = bookmarkData!['covertype'];
              index = widget.typeOfCover.indexOf(bookmarkData['coverType']);

              // print('selected  tab ${_selectedTab}');
              _selectedTab = index;
              // print('selected  tab ${_selectedTab}');
              // print('selected ${bookmarkData['coverType']}');
              // print('selected ${coverTypeSelected}');
              // print('selected ${widget.typeOfCover}');
              print('selected ${index}');
            } catch (e) {
              _userDetails.typeOfCover = "Paperback";
              print(e);
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
    return _selectedTab;
  }
}
