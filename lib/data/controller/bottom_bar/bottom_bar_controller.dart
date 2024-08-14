import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  //On clicked change screen
  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
