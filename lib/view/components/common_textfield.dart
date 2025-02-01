import 'package:flutter/material.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/style.dart';

class CommonTextField extends StatelessWidget {
  TextEditingController? controller;
  double? textFieldHeight;
  Widget? prefixIcon;
  String? hintText;
  TextStyle? hintTexStyle;
  double? paddingTextField;
  Color? fillColor;
  Color? borderColor;
  TextInputType? textInputType;
  double? borderRadius;
  Widget? prefixWidget;
  TextInputAction? textInputAction;
  Widget? suffixIcon;
  ValueChanged? onChange;
  bool? obSecureText;
  Color? cursorColor;

  CommonTextField({
    super.key,
    this.controller,
    this.textFieldHeight,
    this.prefixIcon,
    this.hintText,
    this.hintTexStyle,
    this.paddingTextField,
    this.fillColor,
    this.borderColor,
    this.textInputType,
    this.borderRadius,
    this.prefixWidget,
    this.textInputAction,
    this.suffixIcon,
    this.onChange,
    this.obSecureText,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: textFieldHeight ?? size.height * 0.064,
      padding: EdgeInsets.symmetric(horizontal: paddingTextField ?? 0),
      child: TextField(
        controller: controller,
        cursorColor: cursorColor ?? ColorResources.conceptTextColor,
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: textInputType ?? TextInputType.name,
        style: mediumDefault.copyWith(color: ColorResources.conceptTextColor),
        onChanged: onChange,
        obscureText: obSecureText ?? false,
        decoration: InputDecoration(
          prefixIcon: null,
          prefix: prefixWidget,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: true,
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? Dimensions.defaultRadius),
            borderSide: BorderSide(
                color: borderColor ?? ColorResources.borderColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? Dimensions.defaultRadius),
            borderSide: BorderSide(
                color: borderColor ?? ColorResources.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? Dimensions.defaultRadius),
            borderSide: BorderSide(
                color: borderColor ?? ColorResources.borderColor, width: 1),
          ),
          hintText: hintText ?? "",
          hintStyle: hintTexStyle ??
              mediumDefault.copyWith(color: ColorResources.borderColor),
        ),
      ),
    );
  }
}
