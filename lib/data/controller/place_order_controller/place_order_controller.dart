import 'package:get/get.dart';

class PlaceOrderController extends GetxController {
  bool isSameAsShipping = true;

  void selectAddressOption(bool value) {
    if (isSameAsShipping != value) {
      isSameAsShipping = value;
      update();
    }}
}
