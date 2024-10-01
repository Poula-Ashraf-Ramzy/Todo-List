import 'package:Todo_List/app_colors.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);
typedef BuildCounter = Widget? Function(BuildContext,
    {required int currentLength,
    required bool isFocused,
    required int? maxLength})?;

class MyTextFormField extends StatelessWidget {
  @override
  int? maxLines;
  bool obscureText;
  int? maxTextLength;
  String label;
  TextInputType keyboardType;
  Icon? prefixIcon;
  Color? iconColor;
  Color? floatingLabelStyleColor;
  MyValidator validator;

  BuildCounter? buildCounter;
  TextEditingController controller;

  MyTextFormField(
      {required this.validator,
      required this.controller,
      required this.label,
      this.prefixIcon,
      this.iconColor,
      this.floatingLabelStyleColor,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.maxTextLength,
      this.buildCounter,
      this.maxLines});

  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxTextLength,
      validator: validator,
      buildCounter: buildCounter,
      controller: controller,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.blueColor,
              width: 1,
            ),
            gapPadding: 5),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.blueColor,
              width: 1,
            ),
            gapPadding: 5),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.redColor,
              width: 1,
            ),
            gapPadding: 5),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.redColor,
              width: 1,
            ),
            gapPadding: 5),
        errorMaxLines: 2,
        label: Text(label),
        prefixIcon: prefixIcon,
        prefixIconColor: iconColor,
        floatingLabelStyle: TextStyle(color: floatingLabelStyleColor),
      ),
    );
  }
}
