import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../core/utils/color_resources.dart';

class AppCircularLoader extends StatelessWidget {
  double? radius;

  AppCircularLoader({
    super.key,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return NutsActivityIndicator(
      activeColor: ColorResources.buttonGradientColor,
      inactiveColor: ColorResources.deliveryColor,
      tickCount: 24,
      relativeWidth: 0.4,
      radius: radius ?? 15,
      startRatio: 0.6,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
