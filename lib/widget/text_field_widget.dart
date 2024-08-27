import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controllers;
  final String? labelText;
  final Function? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double? cursorHeight;

  const TextFieldWidget({
    super.key,
    required this.controllers,
    this.labelText,
    this.onTap,
    this.textInputAction,
    this.keyboardType,
    this.cursorHeight = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: TextFormField(
      cursorHeight: cursorHeight,
      keyboardType: keyboardType,
      onTap: onTap as void Function()?,
      textInputAction: textInputAction,
      controller: controllers,
      decoration: InputDecoration(
        // hintText: "Trip name",
        labelText: labelText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ));
  }
}
