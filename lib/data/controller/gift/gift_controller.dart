import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/local_strings.dart';
import '../../../main_controller.dart';

class GiftController extends GetxController {
  final List<String> recipients = [
    LocalStrings.self,
    LocalStrings.friend,
    LocalStrings.family,
    LocalStrings.wife,
    LocalStrings.mother,
    LocalStrings.father,
    LocalStrings.brother,
    LocalStrings.sister,
  ];
}
