import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solatn_gleeks/core/utils/color_resources.dart';
import 'package:solatn_gleeks/core/utils/images.dart';

import '../../core/utils/dimensions.dart';
import '../../core/utils/style.dart';

//Todo : Country picker & number type set common.
class AppTextFieldWidget extends StatelessWidget {
  final Key? formKey;
  final double? width;
  final TextEditingController? controller;
  final int? maxLength;
  final double? borderRadius;
  final Color? borderSideColor;
  final double? borderWidth;
  final String? hintText;
  final ValueChanged<CountryCode>? countryPickerOnChange;
  final double? flagRadius;
  final FormFieldValidator? numberValidator;
  final ValueChanged? numberOnChanged;
  final bool? isShowCountryPicker;
  final double? verticalPadding;
  final Color? fillColor;
  final String? labelText;
  final bool? isEnable;
  final Widget? suffixIcon;
  final TextStyle? suffixTextStyle;
  final EdgeInsetsGeometry? countryPadding;
  final String? initialSelection;
  final double? textFieldHeight;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? boxConstraints;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  AppTextFieldWidget({
    this.formKey,
    this.width = double.infinity,
    this.controller,
    this.maxLength,
    this.borderRadius,
    this.borderSideColor,
    this.borderWidth,
    this.hintText,
    this.countryPickerOnChange,
    this.flagRadius,
    this.numberValidator,
    this.numberOnChanged,
    this.isShowCountryPicker = true,
    this.verticalPadding,
    this.fillColor,
    this.labelText,
    this.isEnable,
    this.suffixIcon,
    this.suffixTextStyle,
    this.countryPadding,
    this.initialSelection,
    this.textFieldHeight,
    this.contentPadding,
    this.boxConstraints,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: SizedBox(
        height: size.height * 0.065,
        width: width,
        child: TextFormField(
          controller: controller,
          maxLength: maxLength ?? 10,
          enabled: isEnable,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? Dimensions.offersCardRadius),
              ),
              borderSide: BorderSide(
                  color: borderSideColor ?? ColorResources.borderColor,
                  width: borderWidth ?? 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? Dimensions.offersCardRadius),
              ),
              borderSide: BorderSide(
                  color: borderSideColor ?? ColorResources.borderColor,
                  width: borderWidth ?? 1.5),
            ),
            hintStyle:
                mediumDefault.copyWith(color: ColorResources.conceptTextColor),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? Dimensions.offersCardRadius),
              ),
              borderSide: BorderSide(
                  color: borderSideColor ?? ColorResources.borderColor,
                  width: borderWidth ?? 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? Dimensions.offersCardRadius),
              ),
              borderSide: BorderSide(
                  color: borderSideColor ?? ColorResources.borderColor,
                  width: borderWidth ?? 1),
            ),
            labelText: labelText,
            labelStyle:
                mediumDefault.copyWith(color: ColorResources.borderColor),
            hintText: hintText ?? '',
            counterText: "",
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            // suffix: ,
            suffixIcon: suffixIcon,
            suffixStyle: suffixTextStyle,
            prefixIconConstraints: boxConstraints ??
                BoxConstraints(
                    minWidth: isShowCountryPicker == true ? 10 : 10.0),
            prefixIcon: isShowCountryPicker == true
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CountryCodePicker(
                        onChanged: print,
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'in',
                        favorite: ['+91', 'in'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                        textStyle: mediumDefault.copyWith(
                            color: ColorResources.conceptTextColor),
                        flagWidth: 22,
                        flagDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(flagRadius ?? 3),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Image.asset(
                        MyImages.downgradeArrowImage,
                        height: size.height * 0.020,
                      ),
                      const SizedBox(width: Dimensions.space5),
                      Container(
                        color: ColorResources.conceptTextColor.withOpacity(0.3),
                        height: size.height * 0.030,
                        width: 1.5,
                      ),
                      const SizedBox(width: Dimensions.space5),
                    ],
                  )
                : const SizedBox(),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: isShowCountryPicker == true ? 20 : 50,
                    vertical: verticalPadding ?? 20),
          ),
          inputFormatters: inputFormatters,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: keyboardType,
          validator: numberValidator,
          onChanged: numberOnChanged,
          style: semiBoldLarge.copyWith(color: ColorResources.conceptTextColor),
        ),
      ),
    );
  }
}
