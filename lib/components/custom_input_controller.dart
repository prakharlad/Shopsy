// ignore_for_file: prefer_final_fields, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopsy/shared/constants.dart';

class CustomInputController extends StatefulWidget {
  final String? showText;
  void Function(String)? onChange;
  void Function(String)? onSubmit;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isMobileNumberField;
  final TextEditingController? inputFieldController;
  final String? initialText;
  // var showIcon;
  bool pwdField;

  CustomInputController(
      {Key? key,
      this.initialText,
      this.inputFieldController,
      this.showText,
      this.isMobileNumberField,
      required this.pwdField,
      this.onSubmit,
      this.focusNode,
      this.textInputAction,
      this.onChange})
      : super(key: key);

  @override
  State<CustomInputController> createState() => _CustomInputControllerState();
}

class _CustomInputControllerState extends State<CustomInputController> {
  @override
  Widget build(BuildContext context) {
    String _initialText = widget.initialText ?? "";
    bool _isMobileNumberField = widget.isMobileNumberField ?? false;
    widget.inputFieldController!.text = _initialText;

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: TextFormField(
        controller: widget.inputFieldController,
        keyboardType:
            _isMobileNumberField ? TextInputType.number : TextInputType.text,
        onChanged: widget.onChange,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmit,
        focusNode: widget.focusNode,
        obscureText: widget.pwdField ? true : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: widget.showText ?? "hint text",
          // suffixIcon: widget.pwdField
          //     ? IconButton(
          //         icon: _obscureText ? widget.showIcon : Icons.visibility_off,
          //         onPressed: widget.pwdField
          //             ? () {
          //                 setState(() {
          //                   _obscureText = !_obscureText;
          //                 });
          //               }
          //             : () {},
          //       )
          //     : IconButton(onPressed: () {}, icon: widget.showIcon),
        ),
        style: Constants.regularText,
      ),
    );
  }
}
