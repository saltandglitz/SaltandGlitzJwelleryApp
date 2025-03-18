import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:saltandGlitz/view/screens/dashboard/dashboard_screen.dart';

import '../../../core/utils/style.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../categories/categories_sccreen.dart';
import '../my_account/my_account_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());

  final List<Widget> pages = [
    const DashboardScreen(),
    CategoriesScreen(),
    MyAccountScreen(), // Replace with actual screen
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.category,
    Icons.account_circle_outlined,
  ];

  final List<String> labels = [
    LocalStrings.home,
    LocalStrings.categories,
    LocalStrings.you,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder(
      init: BottomBarController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: CustomBottomNavigationBar(
            size: size,
            bottomBarController: controller,
            icons: icons,
            labels: labels,
          ),
        );
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final Size size;
  final BottomBarController bottomBarController;
  final List<IconData> icons;
  final List<String> labels;

  CustomBottomNavigationBar({
    required this.size,
    required this.bottomBarController,
    required this.icons,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final categoriesController =
        Get.put<CategoriesController>(CategoriesController());
    return Container(
      height: size.height * 0.080,
      decoration: const BoxDecoration(
        color: ColorResources.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = bottomBarController.selectedIndex.value == index;
          final color = isSelected
              ? ColorResources.blackColor
              : ColorResources.inactiveTabColor;
          return GestureDetector(
            onTap: () {
              bottomBarController.changeIndex(index);
              if (bottomBarController.selectedIndex.value == 1) {
                // Closed categories screen expanded items
                categoriesController.setExpandedIndex(-1);
                categoriesController.setMostBrowsedIndex(-1);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons[index], color: color),
                Text(
                  labels[index],
                  style: mediumLarge.copyWith(color: color),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
