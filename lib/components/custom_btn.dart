// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? showText;
  final Function()? onPressed;
  final bool? isOutlinedBtn;
  final bool? isLoading;

  const CustomBtn(
      {Key? key,
      this.showText,
      this.isOutlinedBtn,
      this.onPressed,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _outlinedBtn = isOutlinedBtn ?? false;
    final _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          height: 60.0,
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(
                    showText ?? "hint text",
                    style: TextStyle(
                        color: _outlinedBtn ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
              ),
              Visibility(
                visible: _isLoading ? true : false,
                child: Center(
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
              ),
              color: _outlinedBtn ? Colors.transparent : Colors.black,
              borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }
}
