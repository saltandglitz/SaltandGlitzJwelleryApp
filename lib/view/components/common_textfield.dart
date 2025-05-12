import 'package:flutter/material.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/style.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? textFieldHeight;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTexStyle;
  final double? paddingTextField;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? textInputType;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixWidget;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;
  final bool? obSecureText;
  final Color? cursorColor;
  final int? maxLines;
  final int? maxLength;
  final Color? textColor;
  final String? Function(String?)? validator;
  final String? errorText; // ✅ NEW: errorText support

  const CommonTextField({
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
    this.contentPadding,
    this.textAlignVertical,
    this.prefixWidget,
    this.textInputAction,
    this.suffixIcon,
    this.onChange,
    this.obSecureText,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textColor,
    this.validator,
    this.errorText, // ✅ Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: textFieldHeight ?? size.height * 0.064,
      padding: EdgeInsets.symmetric(horizontal: paddingTextField ?? 0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        cursorColor: cursorColor ?? ColorResources.buttonColor,
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: textInputType ?? TextInputType.name,
        style: mediumDefault.copyWith(
          color: textColor ?? ColorResources.buttonColor,
        ),
        onChanged: onChange,
        obscureText: obSecureText ?? false,
        textAlignVertical: textAlignVertical,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefix: prefixWidget,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: true,
          contentPadding: contentPadding,
          errorText: errorText, // ✅ Use error text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimensions.circularBorder,
            ),
            borderSide: BorderSide(
              color: borderColor ?? ColorResources.borderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimensions.circularBorder,
            ),
            borderSide: BorderSide(
              color: borderColor ?? ColorResources.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? Dimensions.circularBorder,
            ),
            borderSide: BorderSide(
              color: borderColor ?? ColorResources.borderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.circularBorder),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.circularBorder),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          hintText: hintText ?? "",
          hintStyle: hintTexStyle ??
              mediumDefault.copyWith(color: ColorResources.borderColor),
        ),
      ),
    );
  }
}
