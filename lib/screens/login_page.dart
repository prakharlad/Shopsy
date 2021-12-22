// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shopsy/components/custom_btn.dart';
import 'package:shopsy/components/custom_input.dart';
import 'package:shopsy/components/custom_input_controller.dart';
import 'package:shopsy/firebase_services/firebase_shopsy.dart';
import 'package:shopsy/screens/register_page.dart';
import 'package:shopsy/shared/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _LoginEmail = "";
  String _LoginPassword = "";
  FocusNode? _passwordFocusNode;
  bool _LoginFormLoading = false;
  FirebaseShopsy _firebaseShopsy = FirebaseShopsy();

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode!.dispose();
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
              "Welcome User, \n Login to your account",
              style: Constants.boldHeading,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                CustomInput(
                  showText: "Email...",
                  pwdField: false,
                  onChange: (value) {
                    _LoginEmail = value;
                  },
                  onSubmit: (value) {
                    _passwordFocusNode!.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  // showIcon: Icon(Icons.email),
                ),
                CustomInput(
                  showText: "Password...",
                  pwdField: true,
                  onChange: (value) {
                    _LoginPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  // showIcon: Icon(Icons.visibility),
                  onSubmit: (value) {
                    _submitLoginForm();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: CustomBtn(
                    showText: "Login",
                    isOutlinedBtn: false,
                    isLoading: _LoginFormLoading,
                    onPressed: () {
                      _submitLoginForm();
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                width: 130.0,
                child: Divider(
                  color: Colors.black38,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Or"),
              ),
              SizedBox(
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
                Text("Do not have Account"),
                Expanded(
                  child: CustomBtn(
                    showText: "Create New Account",
                    isOutlinedBtn: true,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
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

  void _submitLoginForm() async {
    setState(() {
      _LoginFormLoading = true;
    });
    String _LoginAccountFeedback = await _firebaseShopsy.LoginUser(
        email: _LoginEmail, password: _LoginPassword);
    if (_LoginAccountFeedback != null) {
      print(_LoginAccountFeedback);
      setState(() {
        _LoginFormLoading = false;
      });
    }
  }
}
