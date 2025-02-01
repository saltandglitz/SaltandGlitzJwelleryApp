import 'package:flutter/material.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/local_strings.dart';
import '../../core/utils/style.dart';

//Common Button
class CommonButton extends StatelessWidget {
  GestureTapCallback? onTap;
  double? height;
  double? width;
  String? buttonName;
  Color? gradientFirstColor;
  Color? gradientSecondColor;
  Color? buttonColor;
  TextStyle? textStyle;
  Widget? child;
  Color? borderColor;

  CommonButton({
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.buttonName,
    this.gradientFirstColor,
    this.gradientSecondColor,
    this.buttonColor,
    this.textStyle,
    this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? size.height * 0.055,
        width: width ?? size.width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.offersCardRadius),
          gradient: LinearGradient(colors: [
            gradientFirstColor ?? ColorResources.offerColor,
            gradientSecondColor ?? ColorResources.buttonGradientColor
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: child ??
              Text(
                buttonName ?? LocalStrings.placeOrder,
                style: textStyle ??
                    mediumLarge.copyWith(
                        color: buttonColor ?? ColorResources.whiteColor),
              ),
        ),
      ),
    );
  }
}
