import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/route/route.dart';
import 'package:solatn_gleeks/core/utils/dimensions.dart';
import 'package:solatn_gleeks/core/utils/images.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';
import 'package:solatn_gleeks/core/utils/style.dart';
import 'package:solatn_gleeks/data/controller/dashboard/dashboard_controller.dart';
import 'package:solatn_gleeks/view/components/cached_image.dart';

import '../../../core/utils/color_resources.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../../components/app_bar_background.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final dashboardController =
      Get.put<DashboardController>(DashboardController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());

  @override
  void initState() {
    super.initState();
    dashboardController.byDefaultMenu();
    dashboardController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await dashboardController.fetchProducts();
        if (dashboardController.products.isNotEmpty &&
            dashboardController.isShowBottomSheet == false) {
          bottomSheetWidget();
        }
        // Mange when app open only single time show bottom sheet recent view products detail
        dashboardController.bottomSheetShowMethod();
      },
    );
  }

  // @override
  // void dispose() {
  //   dashboardController.animationController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              dashboardController.animatedMenuIconChange();
              // Closed categoires screen expanded items
              categoriesController.setExpandedIndex(-1);
              categoriesController.setMostBrowsedIndex(-1);
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: dashboardController.animationController,
              color: ColorResources.conceptTextColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.wishlistScreen);
                  // bottomSheetWidget();
                },
                icon: const Icon(Icons.favorite_rounded),
                color: ColorResources.conceptTextColor),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.addCartScreen);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    color: ColorResources.conceptTextColor),
                // Container(
                //   height: 15,
                //   width: 15,
                //   decoration: new BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   constraints: BoxConstraints(
                //     minWidth: 17,
                //     minHeight: 17,
                //   ),
                //   child: new Text(
                //     '1',
                //     style: new TextStyle(
                //       color: Colors.white,
                //       fontSize: 8,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // )
              ],
            ),
          ],
          backgroundColor: ColorResources.whiteColor,
          // Set the background color of the AppBar
          elevation: 0, // Remove default shadow
        ),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: GetBuilder(
              init: DashboardController(),
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // Show jewellery products autoloop method
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CarouselSlider.builder(
                            key: const PageStorageKey('carousel_slider_key'),
                            // Add PageStorageKey
                            itemCount: controller.imageUrls.length,
                            options: CarouselOptions(
                              onPageChanged: controller.onPageChanged,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 1 / 1.30,
                              viewportFraction: 1,
                            ),
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return CachedCommonImage(
                                networkImageUrl: controller.imageUrls[index],
                                width: double.infinity,
                              );
                            },
                          ),
                          Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.imageUrls.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 15),
                                    child: CircleAvatar(
                                      radius: 3.5,
                                      backgroundColor:
                                          controller.currentIndex.value == i
                                              ? ColorResources.activeCardColor
                                              : ColorResources
                                                  .inactiveCardColor,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space40),
                      Text(
                        LocalStrings.solitaire,
                        textAlign: TextAlign.center,
                        style: regularOverLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontOverSmallLarge),
                      ),
                      const SizedBox(height: Dimensions.space20),
                      // Solitaire Products
                      CarouselSlider.builder(
                        key: const PageStorageKey('carousel_slider_key_second'),
                        // Add PageStorageKey
                        carouselController:
                            controller.carouselSolitaireController,
                        itemCount: 4,
                        options: CarouselOptions(
                          onPageChanged: controller.onPageChangedSolitaire,
                          autoPlay: false,
                          // Disable autoPlay
                          enlargeCenterPage: true,
                          height: size.height * 0.50,
                          viewportFraction: 0.9,
                          enableInfiniteScroll:
                              false, // Disable infinite scroll
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: size.height * 0.50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                  child: CachedCommonImage(
                                    networkImageUrl:
                                        controller.imageUrlsSolitaire[index],
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return controller
                                              .currentSolitaireIndex.value >
                                          0
                                      ? Positioned(
                                          left: 16,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back_ios_rounded,
                                                color: ColorResources
                                                    .inactiveCardColor),
                                            onPressed: () => controller
                                                .goToPreviousSolitaire(),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                              Obx(
                                () {
                                  return controller
                                              .currentSolitaireIndex.value <=
                                          2
                                      ? Positioned(
                                          right: 16,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: ColorResources
                                                    .inactiveCardColor),
                                            onPressed: () =>
                                                controller.goToNextSolitaire(),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space15),

                      Text(
                        LocalStrings.hardwareSolatn,
                        textAlign: TextAlign.center,
                        style: regularExtraLarge.copyWith(),
                      ),
                      Text(
                        LocalStrings.shopNow,
                        textAlign: TextAlign.center,
                        style: regularMediumLarge.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (i) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                child: CircleAvatar(
                                  radius: 3.5,
                                  backgroundColor:
                                      controller.currentSolitaireIndex.value ==
                                              i
                                          ? ColorResources.activeCardColor
                                          : ColorResources.activeCardColor
                                              .withOpacity(0.3),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: Dimensions.space40),

                      Text(
                        LocalStrings.shopBy,
                        textAlign: TextAlign.center,
                        style: boldOverLarge.copyWith(
                            fontSize: Dimensions.fontOverSmallLarge),
                      ),
                      const SizedBox(height: Dimensions.space5),
                      Text(
                        LocalStrings.brilliantDesign,
                        textAlign: TextAlign.center,
                        style: mediumLarge.copyWith(),
                      ),
                      const SizedBox(height: Dimensions.space30),

                      GridView.builder(
                        itemCount: controller.imageShopCategoryImage.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 22.0,
                                childAspectRatio: 7 / 9.5),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: size.height * 0.20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorResources.borderColor,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.circularBorder),
                                  child: CachedCommonImage(
                                    key: const PageStorageKey(
                                        'image_Shop_Category_Image'),
                                    // Add PageStorageKey

                                    width: double.infinity,
                                    networkImageUrl: controller
                                        .imageShopCategoryImage[index],
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space15),
                              Text(
                                controller.imageShopCategoryText[index],
                                textAlign: TextAlign.center,
                                style: regularMediumLarge.copyWith(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space45),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.defaultRadius),
                          child: CachedCommonImage(
                            key: const PageStorageKey('silver_Gifts_Image'),
                            // Add PageStorageKey

                            height: size.height * 0.33,
                            width: double.infinity,
                            networkImageUrl: MyImages.silverGiftsImage,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.defaultRadius),
                          child: CachedCommonImage(
                            key: const PageStorageKey('summer_Rings_Image'),
                            // Add PageStorageKey

                            height: size.height * 0.25,
                            width: double.infinity,
                            networkImageUrl: MyImages.summerRingsImage,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.defaultRadius),
                          child: CachedCommonImage(
                            key: const PageStorageKey('golden_Gifts_Image'),
                            // Add PageStorageKey

                            height: size.height * 0.25,
                            width: double.infinity,
                            networkImageUrl: MyImages.goldenGiftsImage,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space50),
                      // Solitaire Products
                      CarouselSlider.builder(
                        key: const PageStorageKey('image_Gift_Category_Image'),
                        // Add PageStorageKey

                        carouselController: controller.carouselGiftsController,
                        itemCount: 3,
                        options: CarouselOptions(
                          onPageChanged: controller.onPageChangedGifts,
                          autoPlay: false,
                          // Disable autoPlay
                          enlargeCenterPage: true,
                          height: size.height * 0.50,
                          viewportFraction: 0.9,
                          enableInfiniteScroll:
                              false, // Disable infinite scroll
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: size.height * 0.50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                  child: CachedCommonImage(
                                    networkImageUrl: controller
                                        .imageGiftCategoryImage[index],
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return controller.currentGiftsIndex.value > 0
                                      ? Positioned(
                                          left: 16,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back_ios_rounded,
                                                color: ColorResources
                                                    .inactiveCardColor),
                                            onPressed: () =>
                                                controller.goToPreviousGifts(),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                              Obx(
                                () {
                                  return controller.currentGiftsIndex.value <= 1
                                      ? Positioned(
                                          right: 16,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: ColorResources
                                                    .inactiveCardColor),
                                            onPressed: () =>
                                                controller.goToNextGifts(),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space15),

                      Obx(
                        () {
                          return Text(
                            controller.currentGiftsIndex.value == 1
                                ? LocalStrings.giftsHim
                                : controller.currentGiftsIndex.value == 2
                                    ? LocalStrings.giftsHer
                                    : LocalStrings.giftsGraduate,
                            textAlign: TextAlign.center,
                            style: mediumMediumLarge.copyWith(),
                          );
                        },
                      ),
                      Text(
                        LocalStrings.shopNow,
                        textAlign: TextAlign.center,
                        style:
                            regularLarge.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: Dimensions.space15),

                      CachedCommonImage(
                        key: const PageStorageKey('grey_Yost_Jwellary_Image'),
                        // Add PageStorageKey

                        height: size.height * 0.50,
                        networkImageUrl: MyImages.greyYostJwellaryImage,
                      ),
                      const SizedBox(height: Dimensions.space35),

                      GridView.builder(
                        itemCount: controller.servicesTitleText.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 22.0,
                                childAspectRatio: 7 / 9.5),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Spacer(),
                                  Icon(controller.iconList[index]),
                                  const SizedBox(height: Dimensions.space20),
                                  Text(
                                    controller.servicesTitleText[index],
                                    textAlign: TextAlign.center,
                                    style: semiBoldLarge.copyWith(),
                                  ),
                                  const SizedBox(height: Dimensions.space10),
                                  Text(
                                    controller.servicesSubTitleText[index],
                                    textAlign: TextAlign.center,
                                    style: regularSmall.copyWith(),
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.servicesText[index],
                                    textAlign: TextAlign.center,
                                    style: semiBoldSmall.copyWith(),
                                  ),
                                  const SizedBox(height: Dimensions.space10),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space30),

                      CachedCommonImage(
                        key: const PageStorageKey('diamond_Image'),
                        // Add PageStorageKey

                        height: size.height * 0.50,
                        networkImageUrl: MyImages.diamondImage,
                      ),
                      const SizedBox(height: Dimensions.space40),

                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                height: size.height * 0.37,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: Dimensions.space10),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        LocalStrings.clientCare,
                                        textAlign: TextAlign.center,
                                        style: semiBoldLarge.copyWith(),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            controller.clientCareList.length,
                                        padding: const EdgeInsets.only(left: 5),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              controller.clientCareList[index],
                                              style: regularLarge.copyWith(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Container(
                                height: size.height * 0.37,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: Dimensions.space10),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        LocalStrings.ourCompany,
                                        textAlign: TextAlign.center,
                                        style: semiBoldLarge.copyWith(),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            controller.ourCompanyList.length,
                                        padding: const EdgeInsets.only(left: 5),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              controller.ourCompanyList[index],
                                              style: regularLarge.copyWith(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 95),
                        child: Card(
                          child: Container(
                            height: size.height * 0.37,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: Dimensions.space10),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocalStrings.relatedSite,
                                    textAlign: TextAlign.center,
                                    style: semiBoldLarge.copyWith(),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: controller
                                        .realtedSolatnGleeksSitesList.length,
                                    padding: const EdgeInsets.only(left: 5),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          controller
                                                  .realtedSolatnGleeksSitesList[
                                              index],
                                          style: regularLarge.copyWith(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space30),
                      Text(
                        LocalStrings.latestSolatnGleeks,
                        textAlign: TextAlign.center,
                        style: semiBoldLarge.copyWith(),
                      ),
                      const SizedBox(height: Dimensions.space20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          LocalStrings.knowAbout,
                          textAlign: TextAlign.center,
                          style: regularLarge.copyWith(),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space20),
// Email enter textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: controller.email,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius)),
                            hintText: LocalStrings.email,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space12),
// Signup Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 135),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: ColorResources.buttonColorDark,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius)),
                            child: Center(
                              child: Text(
                                LocalStrings.signUp,
                                textAlign: TextAlign.center,
                                style: semiBoldLarge.copyWith(
                                  color: ColorResources.inactiveCardColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space20),

                      // Set social media share icon
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_business_outlined),
                          SizedBox(width: Dimensions.space25),
                          Icon(Icons.facebook),
                          SizedBox(width: Dimensions.space25),
                          Icon(Icons.face),
                          SizedBox(width: Dimensions.space25),
                          Icon(Icons.yard_outlined),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space5),
                    ],
                  ),
                );
              })),
    );
  }

  // Bottom sheet User product recently view
  bottomSheetWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      return showModalBottomSheet(
        backgroundColor: ColorResources.cardBgColor,
        isScrollControlled: true,
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.bottomSheetRadius),
              topLeft: Radius.circular(Dimensions.bottomSheetRadius)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.61,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorResources.cardBgColor,
              borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  color: ColorResources.offerThirdTextColor.withOpacity(0.1),
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: Dimensions.space10),
                      Container(
                        height: 5,
                        width: 40,
                        color: ColorResources.whiteColor,
                      ),
                      const SizedBox(height: Dimensions.space50),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${LocalStrings.hi}, ",
                            style: semiBoldMediumLarge.copyWith(
                              color: ColorResources.conceptTextColor,
                            ),
                          ),
                          Text(
                            "Xyz",
                            style: semiBoldMediumLarge.copyWith(
                              color: ColorResources.conceptTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space3),
                Text(
                  LocalStrings.yourCartWaiting,
                  style: semiBoldMediumLarge.copyWith(
                    color: ColorResources.conceptTextColor,
                  ),
                ),
                GetBuilder(
                    init: DashboardController(),
                    builder: (controller) {
                      return Flexible(
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              top: 40, left: 15, right: 15),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 35),
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.18,
                                    width: size.width * 0.35,
                                    decoration: BoxDecoration(
                                      color: ColorResources.borderColor
                                          .withOpacity(0.01),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.offersCardRadius),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.offersCardRadius),
                                      child: Image.asset(
                                          controller.products[index]['image']),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space20),
                                  Text(
                                    controller.products[index]['name'],
                                    style: regularDefault.copyWith(
                                        color: ColorResources.buttonColorDark),
                                  ),
                                  const SizedBox(height: Dimensions.space1),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${controller.products[index]['totalCost']}",
                                        style: mediumDefault.copyWith(
                                            color:
                                                ColorResources.buttonColorDark),
                                      ),
                                      const SizedBox(width: Dimensions.space2),
                                      Text(
                                        "₹${controller.products[index]['totalCost']}",
                                        style: dateTextStyle.copyWith(
                                            color:
                                                ColorResources.buttonColorDark,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.addCartScreen);
                  },
                  child: Container(
                      height: size.height * 0.080,
                      decoration: const BoxDecoration(
                        color: ColorResources.conceptTextColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.borderColor,
                            offset: Offset(0, 1),
                            // Position the shadow below the AppBar
                            blurRadius: 2, // Adjust the blur radius as needed
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          LocalStrings.goToCart,
                          style: mediumMediumLarge.copyWith(
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
