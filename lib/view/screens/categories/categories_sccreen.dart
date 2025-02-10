import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/categories/categories_controller.dart';
import 'package:saltandGlitz/view/screens/categories/women_categories_screen.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/dashboard/dashboard_controller.dart';
import '../../components/app_bar_background.dart';
import 'men_categories_screen.dart';

class CategoriesScreen extends StatefulWidget {
  String? screenType;

  CategoriesScreen({super.key, this.screenType});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  final dashboardController =
      Get.put<DashboardController>(DashboardController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());

  @override
  void initState() {
    super.initState();
    //Todo : Get by default women categories data api method
    // categoriesController.getCategories(LocalStrings.womenCategoriesApi);
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logCategories, index: 1);
    AppAnalytics().actionTriggerLogs(
        eventName: LocalStrings.logCategoriesWomenView, index: 1);
    if (Get.arguments != null) {
      widget.screenType = Get.arguments[0];
      print("Passed : ${widget.screenType}");
    }
    dashboardController.categoriesDefaultCloseIcon();
    dashboardController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      init: CategoriesController(),
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: ColorResources.scaffoldBackgroundColor,
            appBar: AppBarBackground(
              additionalHeight: 48.0, // Height of TabBar
              isShowTabBar: true,
              tabBarWidget: Container(
                color: ColorResources.whiteColor,
                child: TabBar(
                  onTap: (value) {
                    if (value == 0) {
                      /// Women categories analysis
                      AppAnalytics().actionTriggerLogs(
                          eventName: LocalStrings.logCategoriesWomenView,
                          index: 1);
                      categoriesController.setExpandedIndex(-1);
                      categoriesController.setMostBrowsedIndex(-1);
                    } else {
                      /// Men categories analysis
                      AppAnalytics().actionTriggerLogs(
                          eventName: LocalStrings.logCategoriesMenView,
                          index: 1);
                      categoriesController.setMenExpandedIndex(-1);
                      categoriesController.setMenBrowsedIndex(-1);
                    }
                  },
                  tabs: controller.myTabs,
                  unselectedLabelColor: ColorResources.conceptTextColor,
                  labelStyle: semiBoldLarge.copyWith(),
                ),
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                leading: IconButton(
                  onPressed: () {
                    widget.screenType == 'Products_Categories'
                        ? Get.back()
                        : dashboardController.animatedMenuIconChange();
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.close_menu,
                    progress: dashboardController.animationController,
                    color: ColorResources.conceptTextColor,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_rounded),
                    color: ColorResources.conceptTextColor,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.addCartScreen);
                        },
                        icon: const Icon(Icons.shopping_cart),
                        color: ColorResources.conceptTextColor,
                      ),
                    ],
                  ),
                ],
                backgroundColor: ColorResources.whiteColor,
                elevation: 0,
              ),
            ),
            body: const SafeArea(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  WomenCategoriesScreen(),
                  MenCategoriesScreen(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
