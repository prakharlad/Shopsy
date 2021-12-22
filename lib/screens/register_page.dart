// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_btn.dart';
import 'package:shopsy/components/custom_input.dart';
import 'package:shopsy/components/custom_input_controller.dart';
import 'package:shopsy/firebase_services/firebase_shopsy.dart';
import 'package:shopsy/shared/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//  Default Login form State
  bool _registerFormLoading = false;

// Register Form input fields
  String _registerEmail = "";
  String _registerPassword = "";
  String _registerFirstName = "";
  String _registerLastName = "";
  String _registerConfirmPassword = "";
  String _registerGender = "";
  int? _registerAge;
  int? _registerMobileNumber;

// focus node for input fields
  FocusNode? _lastNamefocusNode;
  FocusNode? _genderfocusNode;
  FocusNode? _agefocusNode;
  FocusNode? _emailfocusNode;
  FocusNode? _passwordfocusNode;
  FocusNode? _confirmpasswordfocusNode;
  FocusNode? _mobileNumberfocusNode;
  FirebaseShopsy _firebaseShopsy = FirebaseShopsy();

  @override
  void initState() {
    _lastNamefocusNode = FocusNode();
    _genderfocusNode = FocusNode();
    _agefocusNode = FocusNode();
    _mobileNumberfocusNode = FocusNode();
    _emailfocusNode = FocusNode();
    _passwordfocusNode = FocusNode();
    _confirmpasswordfocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordfocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 24.0),
            child: Text(
              "Welcome User, \n Create New Account",
              style: Constants.boldHeading,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                CustomInput(
                  // showIcon: Icon(Icons.email),
                  // fieldType: "first name",

                  showText: " First Name ",
                  pwdField: false,
                  onChange: (value) {
                    _registerFirstName = value;
                  },
                  onSubmit: (value) {
                    _lastNamefocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "last name",
                  // showIcon: Icon(Icons.email),
                  showText: " Last Name ",
                  pwdField: false,
                  focusNode: _lastNamefocusNode,

                  onChange: (value) {
                    _registerLastName = value;
                  },
                  onSubmit: (value) {
                    _genderfocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "gender",
                  // showIcon: Icon(Icons.email),
                  showText: " Gender ",
                  pwdField: false,
                  focusNode: _genderfocusNode,

                  onChange: (value) {
                    _registerGender = value;
                  },
                  onSubmit: (value) {
                    _agefocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "age",
                  // showIcon: Icon(Icons.email),
                  showText: " Age ",
                  pwdField: false,
                  focusNode: _agefocusNode,
                  isMobileNumberField: true,
                  onChange: (value) {
                    _registerAge = int.parse(value);
                  },
                  onSubmit: (value) {
                    _mobileNumberfocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "mobile number",
                  // showIcon: Icon(Icons.email),
                  showText: " Mobile Number ",
                  pwdField: false,
                  focusNode: _mobileNumberfocusNode,
                  isMobileNumberField: true,
                  onChange: (value) {
                    _registerMobileNumber = int.parse(value);
                  },
                  onSubmit: (value) {
                    _emailfocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "email",
                  // showIcon: Icon(Icons.email),
                  showText: " Email ",
                  pwdField: false,
                  focusNode: _emailfocusNode,
                  onChange: (value) {
                    _registerEmail = value;
                  },
                  onSubmit: (value) {
                    _passwordfocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  // fieldType: "password",
                  // showIcon: Icon(Icons.visibility),
                  textInputAction: TextInputAction.next,

                  showText: " Password ",
                  pwdField: true,
                  onChange: (value) {
                    _registerPassword = value;
                  },
                  focusNode: _passwordfocusNode,
                  onSubmit: (value) {
                    // _submitRegisterForm();
                    _confirmpasswordfocusNode!.requestFocus();
                  },
                ),
                CustomInput(
                  // fieldType: "confirm password",
                  // showIcon: Icon(Icons.email),
                  showText: " Confirm Password ",
                  pwdField: true,
                  focusNode: _confirmpasswordfocusNode,

                  onChange: (value) {
                    _registerConfirmPassword = value;
                  },
                  onSubmit: (value) {
                    // print('print ${_registerFirstName}');
                    // print('print ${_registerLastName}');
                    // print('print ${_registerGender}');
                    // print('print ${_registerAge}');
                    // print('print ${_registerEmail}');
                    // print('print ${_registerPassword}');
                    // print('print ${_registerConfirmPassword}');

                    _submitRegisterForm();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: CustomBtn(
                    showText: "Create New Account",
                    isOutlinedBtn: false,
                    onPressed: () {
                      _submitRegisterForm();
                      // print('print ${_registerFirstName}');
                      // print('print ${_registerLastName}');
                      // print('print ${_registerGender}');
                      // print('print ${_registerAge}');
                      // print('print ${_registerEmail}');
                      // print('print ${_registerPassword}');
                      // print('print ${_registerConfirmPassword}');
                    },
                    isLoading: _registerFormLoading,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                width: 130.0,
                child: Divider(
                  color: Colors.black38,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Or"),
              ),
              const SizedBox(
                width: 130.0,
                child: Divider(
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Already have an Account"),
                Expanded(
                  child: CustomBtn(
                    showText: "Back to Login",
                    isOutlinedBtn: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _submitRegisterForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _createAccountFeedback = await _firebaseShopsy.CreateUser(
        email: _registerEmail, password: _registerPassword);
    // TODO : Create an alert box for feedBack
// if no error occured then send all details to user page
    if (_createAccountFeedback == null) {
      User? _user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('User').doc(_user!.uid).set({
        'first name': _registerFirstName,
        'last name': _registerLastName,
        'gender': _registerGender,
        'age': _registerAge,
        'email': _registerEmail,
        'mobile number': _registerMobileNumber,
      });
    }

// if there is error while registering
    if (_createAccountFeedback != null) {
      // TODO:  print alert box or validator

      print('user feedback ${_createAccountFeedback}');

      setState(() {
        _registerFormLoading = false;
      });
    }

    //  Every thing goes well user registered successfully so head back to Login Page.
    //Login Page which will be monitered by Stream builder which detect auth changes
    //and head towards home Page
    else {
      Navigator.pop(context);
    }
  }
}
