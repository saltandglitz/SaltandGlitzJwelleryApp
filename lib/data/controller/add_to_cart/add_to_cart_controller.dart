import 'dart:async';

import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';

class AddToCartController extends GetxController {
  int currentIndex = 0;
  Timer? timer;

  static const List<Map<String, String>> texts = [
    {"title": LocalStrings.pointsOrder, "subtitle": LocalStrings.nextOrder},
    {"title": LocalStrings.oderOnline, "subtitle": LocalStrings.sameDay},
  ];

  List productsImage = [
    MyImages.ringsProductsImage,
    MyImages.earringsProductsImage,
    MyImages.chainProductsImage
  ];
  List productsName = [
    LocalStrings.rings,
    LocalStrings.earrings,
    LocalStrings.chain
  ];
  List productQuantity = [
    LocalStrings.quantityFirst,
    LocalStrings.quantitySecond,
    LocalStrings.quantityFirst,
  ];
  List productsSize = [
    LocalStrings.sizeFirst,
    LocalStrings.sizeSecond,
    LocalStrings.sizeThird,
  ];

  // animation text show offers
  implementAnimationOffersMethod() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      currentIndex = (currentIndex + 1) % texts.length;
      update();
    });
  }
}
