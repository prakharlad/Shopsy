// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/components/custom_input_controller.dart';
import 'package:shopsy/firebase_services/firebase_shopsy.dart';
import 'package:shopsy/model/user_model.dart';
import 'package:shopsy/shared/constants.dart';

class EditProfilePage extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? gender;
  final int? age;
  final int? mobileNumber;
  final String? email;

  CollectionReference<Map<String, dynamic>> _userRef =
      FirebaseFirestore.instance.collection('User');

  User? _user = FirebaseAuth.instance.currentUser;
  UserDetails userDetails = UserDetails();
  Constants constants = Constants();

  EditProfilePage(
      {Key? key,
      this.firstName,
      this.lastName,
      this.gender,
      this.age,
      this.mobileNumber,
      this.email})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //  Default Login form State
  bool _editFormLoading = false;

  // Edit Form input fields
  String _editFirstName = "";
  String _editLastName = "";
  String _editGender = "";
  int? _editAge;
  int? _editMobileNumber;
  String _editEmail = "";

// focus node for input fields
  FocusNode? _lastNamefocusNode;
  FocusNode? _genderfocusNode;
  FocusNode? _agefocusNode;
  FocusNode? _emailfocusNode;
  FocusNode? _passwordfocusNode;
  FocusNode? _confirmpasswordfocusNode;
  FocusNode? _mobileNumberfocusNode;
  FirebaseShopsy _firebaseShopsy = FirebaseShopsy();

// input Field controllers
  TextEditingController _firstNameFieldController = TextEditingController();
  TextEditingController _lastNameFieldController = TextEditingController();
  TextEditingController _genderFieldController = TextEditingController();
  TextEditingController _ageFieldController = TextEditingController();
  TextEditingController _mobileNumberFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CustomActionBar(
                hasSave: true,
                onSaveBtnPressed: () async {
                  // print('hey ${widget.firstName}');
                  // print('hey ${widget.lastName}');
                  // print('hey ${widget.gender}');
                  // print('hey ${widget.age}');
                  // print('hey ${widget.mobileNumber}');
                  // print('hey ${widget.email}');

                  _submitEditForm(
                      firstName: _editFirstName == ""
                          ? widget.firstName!
                          : _editFirstName,
                      lastName: _editLastName == ""
                          ? widget.lastName!
                          : _editLastName,
                      gender: _editGender == "" ? widget.gender : _editGender,
                      age: _editAge == null ? widget.age : _editAge,
                      mobileNumber: _editMobileNumber == null
                          ? widget.mobileNumber!
                          : _editMobileNumber,
                      email: _editEmail == "" ? widget.email! : _editEmail);
                  // print('hey ${widget.firstName}');
                  // print('hey ${widget.lastName}');
                  // print('hey ${widget.gender}');
                  // print('hey ${widget.age}');
                  // print('hey ${widget.mobileNumber}');
                  // print('hey ${widget.email}');
                },
                hasEditAction: false,
                hasBackArrow: true,
                hasCart: false,
                hasTitle: true,
                isLoading: _editFormLoading,
                hasBackBtnAction: true,
                hasBackGround: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                title: " Edit Profile ",
              ),
              CustomInputController(
                // showIcon: Icon(Icons.email),
                inputFieldController: _firstNameFieldController,
                initialText: widget.firstName,
                showText: " First Name ",
                pwdField: false,
                onChange: (value) {
                  if (value != "") {
                    _editFirstName = value;
                  } else {
                    _editFirstName = widget.firstName!;
                  }
                },

                onSubmit: (value) {
                  if (_editFirstName == "") {
                    _editFirstName = widget.firstName!;
                  } else {
                    _editFirstName = value;
                  }
                  _lastNamefocusNode!.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInputController(
                inputFieldController: _lastNameFieldController,
                initialText: widget.lastName,
                showText: " Last Name ",
                pwdField: false,
                focusNode: _lastNamefocusNode,
                onChange: (value) {
                  if (value != "") {
                    _editLastName = value;
                  } else {
                    _editLastName = widget.lastName!;
                  }
                },
                onSubmit: (value) {
                  if (_editLastName == "") {
                    _editLastName = widget.lastName!;
                  } else {
                    _editLastName = value;
                  }
                  _genderfocusNode!.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInputController(
                inputFieldController: _genderFieldController,
                initialText: widget.gender,
                showText: " Gender ",
                pwdField: false,
                focusNode: _genderfocusNode,
                onChange: (value) {
                  if (value != "") {
                    _editGender = value;
                  } else {
                    _editGender = widget.gender!;
                  }
                },
                onSubmit: (value) {
                  if (_editGender == "") {
                    _editGender = widget.gender!;
                  } else {
                    _editGender = value;
                  }

                  _agefocusNode!.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInputController(
                inputFieldController: _ageFieldController,
                initialText: "${widget.age}",
                showText: " Age ",
                pwdField: false,
                focusNode: _agefocusNode,
                isMobileNumberField: true,
                onChange: (value) {
                  if (value != "") {
                    _editAge = int.parse(value);
                  } else {
                    _editAge = widget.age;
                  }
                },
                onSubmit: (value) {
                  if (_editAge == "" || _editAge == null) {
                    _editAge = widget.age!;
                  } else {
                    _editAge = int.parse(value);
                  }
                  _mobileNumberfocusNode!.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInputController(
                inputFieldController: _mobileNumberFieldController,
                initialText: "${widget.mobileNumber}",
                showText: " Mobile Number ",
                pwdField: false,
                focusNode: _mobileNumberfocusNode,
                isMobileNumberField: true,
                onChange: (value) {
                  if (value == "") {
                    _editMobileNumber = int.parse(value);
                  } else {
                    _editMobileNumber = widget.mobileNumber;
                  }
                },
                onSubmit: (value) {
                  if (_editMobileNumber == "" || _editAge == null) {
                    _editMobileNumber = widget.mobileNumber!;
                  } else {
                    _editMobileNumber = int.parse(value);
                  }
                  _emailfocusNode!.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInputController(
                inputFieldController: _emailFieldController,
                initialText: widget.email,
                showText: " Email ",
                pwdField: false,
                focusNode: _emailfocusNode,
                onChange: (value) {
                  if (value != "") {
                    _editEmail = value;
                  } else {
                    _editEmail = widget.email!;
                  }
                },
                onSubmit: (value) {
                  if (_editEmail == "") {
                    _editEmail = widget.email!;
                  } else {
                    _editEmail = value;
                  }
                  // print('hey ${_editFirstName}');
                  // print('hey ${_editLastName}');
                  // print('hey ${_editGender}');
                  // print('hey ${_editAge}');
                  // print('hey ${_editMobileNumber}');
                  // print('hey ${_editEmail}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitEditForm(
      {String? firstName,
      String? lastName,
      String? gender,
      int? age,
      int? mobileNumber,
      String? email}) async {
    setState(() {
      _editFormLoading = true;
    });

    User? _user = await FirebaseAuth.instance.currentUser;
    // TODO : Create an alert box for feedBack

    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(_user!.uid)
          .update({
        'first name': firstName,
        'last name': lastName,
        'gender': gender,
        'age': age,
        'email': email,
        'mobile number': mobileNumber,
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _editFormLoading = false;
      });
    }
  }
}
