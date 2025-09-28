import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/core/utils/color_resources.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:saltandglitz/view/screens/dashboard/dashboard_screen.dart';
import 'package:saltandglitz/view/screens/pop/pop_screen.dart';

import '../../../core/utils/style.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../categories/categories_screen.dart';
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
    const PopScreen(),
    MyAccountScreen(),
    // Replace with actual screen
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.grid_view,
    Icons.flare,
    Icons.account_circle_outlined,
  ];

  final List<String> labels = [
    LocalStrings.home,
    LocalStrings.categories,
    "pop",
    LocalStrings.you,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {
        showExitConfirmationDialog(context);
      },
      canPop: false,
      child: GetBuilder(
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
      ),
    );
  }

  /// Exit app dialogBox
  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(LocalStrings.exitApp),
            content: Text(LocalStrings.askExit),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(LocalStrings.no),
              ),
              TextButton(
                onPressed: () {
                  /// Kill App
                  exit(0);
                },
                child: Text(LocalStrings.yes),
              ),
            ],
          ),
        ) ??
        false;
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
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: size.height * 0.080 + bottomPadding,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
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
            children: List.generate(
              icons.length,
              (index) {
                final isSelected =
                    bottomBarController.selectedIndex.value == index;
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
