import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? hintText;
  IconButton? suffixIconButton;
  CustomTextField({this.suffixIconButton,this.hintText, super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 40,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
          suffixIcon: suffixIconButton,
          hintText: hintText,
          focusColor: Colors.redAccent,
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.black,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid, width: 1)
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid, width: 1)
          ),
        ),

      ),
    );
  }
}
