import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_resources.dart';
import '../../core/utils/images.dart';
import '../../core/utils/local_strings.dart';
import '../../core/utils/style.dart';
import '../../main.dart';
import 'common_button.dart';

class NetworkConnectivityView extends StatelessWidget {
  GestureTapCallback? onTap;
  RxBool? isLoading;

  NetworkConnectivityView({super.key, this.onTap, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: CommonButton(
            onTap: onTap,
            child: isLoading?.value == true
                ? CircularProgressIndicator()
                : Text(
                    LocalStrings.retry,
                    style:
                        mediumLarge.copyWith(color: ColorResources.whiteColor),
                  ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      ColorResources.offerColor.withOpacity(0.5),
                      ColorResources.buttonGradientColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  MyImages.noInternet,
                  fit: BoxFit.fill,
                  height: 130,
                  width: 130,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              LocalStrings.noDetectInternet,
              textAlign: TextAlign.center,
              style: boldLarge.copyWith(),
            ),
          ],
        ),
      ],
    );
  }
}
