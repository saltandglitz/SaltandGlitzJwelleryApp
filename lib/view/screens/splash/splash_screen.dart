import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/categories/categories_controller.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/product/product_controller.dart';
import '../../../main_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final mainController = Get.put<MainController>(MainController());
  final dashboardController =
      Get.put<DashboardController>(DashboardController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());
  final productController = Get.put<ProductController>(ProductController());

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    //Todo : Banner data show api method
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await mainController.getDashboardJewelleryData();
      for (int i = 0; i < bottomBannerList.length; i++) {
        String? media = bottomBannerList[i].bannerImage;
        dashboardController.handleMediaPlayback(media: media!, index: i);
      }
      // await mainController.getBannerData();
      // await mainController.getCategoryData();
      // await mainController.getNewArrivalData();
      // await mainController.getFilterCategoryData();
      // await mainController.getGiftElementData();
      // await mainController.getSolitaireData();
      // await mainController.getBottomBannerData();
      //Todo : Get by default women categories data api method
      await categoriesController.getFemaleCategories();
      print("Bottom banner length : ${getCategoryData.length}");
      //Todo : Get men categories data api method
      await categoriesController.getMaleCategories();
      print("Bottom banner length : ${getCategoryMaleData.length}");
      // await productController.youMayAlsoLike();
    });
    mainController.splashScreenNavigation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Stack(
              // alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: size.height * 0.70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorResources.splashFirstColor,
                        ColorResources.splashSecondColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      MyImages.starsSplashBgImage,
                      height: size.height * 0.35,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      color: ColorResources.whiteColor,
                    ),
                    const SizedBox(height: Dimensions.space50),
                    Text(
                      LocalStrings.appName,
                      textAlign: TextAlign.center,
                      style: regularOverLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.whiteColor,
                        fontSize: Dimensions.fontMegaLarge,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: size.height * 0.60,
                  left: size.width * 0.20,
                  right: size.width * 0.20,
                  child: Image.asset(
                    MyImages.ringOneImage,
                    height: 200,
                    width: 200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
