import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/core/utils/style.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
import 'package:saltandGlitz/view/components/cached_image.dart';
import 'package:saltandGlitz/view/components/common_button.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
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
  final dashboardController = Get.put<DashboardController>(
    DashboardController(),
  );
  TextEditingController searchController = TextEditingController();
  final categoriesController = Get.put<CategoriesController>(
    CategoriesController(),
  );
  /* *********************************************************************************************************** */
  // late VideoPlayerController _controller;

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
        // Manage when app open only single time show bottom sheet recent view products detail
        dashboardController.bottomSheetShowMethod();
      },
    );
    /* *********************************************************************************************************** */
    // _controller = VideoPlayerController.network(
    //   'https://cdn.caratlane.com/media/catalog/product/S/R/SR04121-YGP900_16_video.mp4',
    // )
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play(); // Automatically play the video
    //   })
    //   ..setLooping(true);
  }

  /* *********************************************************************************************************** */
  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.pause(); // Pause the video and audio when navigating away
  //   _controller.dispose(); // Dispose of the controller
  // }

  // @override
  // void dispose() {
  //   dashboardController.animationController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              dashboardController.animatedMenuIconChange();
              // Closed categories screen expanded items
              categoriesController.setExpandedIndex(-1);
              categoriesController.setMostBrowsedIndex(-1);
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: dashboardController.animationController,
              color: ColorResources.iconColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(RouteHelper.wishlistScreen);
                // bottomSheetWidget();
              },
              icon: const Icon(Icons.favorite_rounded),
              color: ColorResources.iconColor,
            ),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.addCartScreen);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: ColorResources.iconColor,
                ),
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
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: CommonTextField(
                      controller: searchController,
                      hintText: LocalStrings.search,
                      fillColor: ColorResources.whiteColor,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: ColorResources.iconColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  /* category */
                  Container(
                    height: size.height * 0.14,
                    child: GridView.builder(
                      itemCount: controller.imageShopCategoryImage.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10.0,
                        // childAspectRatio: 1.0,
                        mainAxisExtent: 90,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.height * 0.11,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                image: DecorationImage(
                                    image: NetworkImage(controller
                                        .imageShopCategoryImage[index]),
                                    fit: BoxFit.cover),
                              ),

                              // child: CachedCommonImage(
                              //   key: const PageStorageKey(
                              //       'image_Shop_Category_Image'),
                              //   // Add PageStorageKey
                              //   width: double.infinity,
                              //   networkImageUrl:
                              //       controller.imageShopCategoryImage[index],
                              // ),
                            ),
                            const SizedBox(height: Dimensions.space5),
                            Text(
                              controller.imageShopCategoryText[index],
                              textAlign: TextAlign.center,
                              style: regularDefault.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  /* Show jewellery products auto loop method */
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
                          aspectRatio: 1 / 0.99,
                          viewportFraction: 1,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return CachedCommonImage(
                            networkImageUrl: controller.imageUrls[index],
                            width: double.infinity,
                          );
                        },
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.imageUrls.length,
                            (i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 15,
                              ),
                              child: CircleAvatar(
                                radius: 3.5,
                                backgroundColor:
                                    controller.currentIndex.value == i
                                        ? ColorResources.activeCardColor
                                        : ColorResources.inactiveCardColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space30),
                  /* *********************************************************************************************************** */
                  // Container(
                  //   height: size.height * 0.5,
                  //   child: VisibilityDetector(
                  //     key: Key('video-key'),
                  //     onVisibilityChanged: (visibilityInfo) {
                  //       // Pause the video when it's not visible
                  //       if (visibilityInfo.visibleFraction == 0) {
                  //         _controller.pause();
                  //       } else {
                  //         _controller.play();
                  //       }
                  //     },
                  //     child: Container(
                  //       height: 200,
                  //       child: _controller.value.isInitialized
                  //           ? AspectRatio(
                  //               aspectRatio: _controller.value.aspectRatio,
                  //               child: VideoPlayer(_controller),
                  //             )
                  //           : Center(child: CircularProgressIndicator()),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: Dimensions.space30),
                  /* Solitaire Products */
                  Text(
                    LocalStrings.solitaire,
                    textAlign: TextAlign.center,
                    style: regularOverLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  // CarouselSlider.builder(
                  //   key: const PageStorageKey('carousel_slider_key_second'),
                  //   // Add PageStorageKey
                  //   carouselController: controller.carouselSolitaireController,
                  //   itemCount: 4,
                  //   options: CarouselOptions(
                  //     onPageChanged: controller.onPageChangedSolitaire,
                  //     autoPlay: false,
                  //     // Disable autoPlay
                  //     enlargeCenterPage: true,
                  //     height: size.height * 0.45,
                  //     viewportFraction: 0.9,
                  //     enableInfiniteScroll: false, // Disable infinite scroll
                  //   ),
                  //   itemBuilder:
                  //       (BuildContext context, int index, int realIndex) {
                  //     return Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         Container(
                  //           height: size.height * 0.45,
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(
                  //                 Dimensions.defaultRadius),
                  //           ),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(
                  //                 Dimensions.defaultRadius),
                  //             child: CachedCommonImage(
                  //               networkImageUrl:
                  //                   controller.imageUrlsSolitaire[index],
                  //             ),
                  //           ),
                  //         ),
                  //         Obx(
                  //           () {
                  //             return controller.currentSolitaireIndex.value > 0
                  //                 ? Positioned(
                  //                     left: 16,
                  //                     child: IconButton(
                  //                       icon: const Icon(
                  //                         Icons.arrow_back_ios_rounded,
                  //                         color:
                  //                             ColorResources.inactiveCardColor,
                  //                       ),
                  //                       onPressed: () =>
                  //                           controller.goToPreviousSolitaire(),
                  //                     ),
                  //                   )
                  //                 : const SizedBox();
                  //           },
                  //         ),
                  //         Obx(
                  //           () {
                  //             return controller.currentSolitaireIndex.value <= 2
                  //                 ? Positioned(
                  //                     right: 16,
                  //                     child: IconButton(
                  //                       icon: const Icon(
                  //                         Icons.arrow_forward_ios_rounded,
                  //                         color:
                  //                             ColorResources.inactiveCardColor,
                  //                       ),
                  //                       onPressed: () =>
                  //                           controller.goToNextSolitaire(),
                  //                     ),
                  //                   )
                  //                 : const SizedBox();
                  //           },
                  //         )
                  //       ],
                  //     );
                  //   },
                  // ),
                  Container(
                    height: size.height * 0.30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1.5,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.imageSolitaire.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.1),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.imageSolitaire[index],
                                      ),
                                      // fit: BoxFit.fill,
                                    ),
                                  ),

                                  // child: CachedCommonImage(
                                  //   key: const PageStorageKey(
                                  //       'image_Shop_Category_Image'),
                                  //   // Add PageStorageKey
                                  //   width: double.infinity,
                                  //   networkImageUrl:
                                  //       controller.imageShopCategoryImage[index],
                                  // ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  controller.imageSolitaireText[index],
                                  textAlign: TextAlign.center,
                                  style: regularDefault.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${controller.solitairePriceText[index]}",
                                  textAlign: TextAlign.center,
                                  style: regularDefault.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  /* View All Button */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: CommonButton(
                      onTap: () {
                        Get.toNamed(RouteHelper.collectionScreen);
                      },
                      gradientFirstColor: ColorResources.whiteColor,
                      gradientSecondColor: ColorResources.whiteColor,
                      borderColor: ColorResources.conceptTextColor,
                      height: size.height * 0.05,
                      child: Text(
                        LocalStrings.viewAll,
                        style: mediumDefault.copyWith(
                          color: ColorResources.conceptTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space40),
                  /*shop by category*/
                  Text(
                    LocalStrings.shopBy,
                    textAlign: TextAlign.center,
                    style: regularOverLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(
                    LocalStrings.brilliantDesign,
                    textAlign: TextAlign.center,
                    style: mediumLarge.copyWith(),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Column(
                    children: List<Widget>.generate(
                      2,
                      (rowIndex) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 190,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List<Widget>.generate(
                                3,
                                (index) {
                                  int imageIndex = rowIndex * 3 + index;
                                  double offsetY = (index % 2 == 0) ? 20 : -10;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.translate(
                                        offset: Offset(0, offsetY),
                                        child: buildContainer(
                                          controller.imageShopCategoryImage[
                                              imageIndex],
                                        ),
                                      ),
                                      const SizedBox(height: Dimensions.space5),
                                      Transform.translate(
                                        offset: Offset(0, offsetY),
                                        child: Text(
                                          controller.imageShopCategoryText[
                                              imageIndex],
                                          style: regularDefault.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign
                                              .center, // Center text alignment
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.space40),
                  /* New Arrival */
                  Text(
                    LocalStrings.newArrival,
                    textAlign: TextAlign.center,
                    style: regularOverLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Container(
                    height: size.height * 0.30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1.5,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.imageSolitaire.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.1),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.imageSolitaire[index],
                                      ),
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  controller.imageSolitaireText[index],
                                  textAlign: TextAlign.center,
                                  style: regularDefault.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${controller.newArrivalPriceText[index]}",
                                  textAlign: TextAlign.center,
                                  style: regularDefault.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  /* View All Button */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: CommonButton(
                      onTap: () {
                        Get.toNamed(RouteHelper.collectionScreen);
                      },
                      gradientFirstColor: ColorResources.whiteColor,
                      gradientSecondColor: ColorResources.whiteColor,
                      borderColor: ColorResources.conceptTextColor,
                      height: size.height * 0.05,
                      child: Text(
                        LocalStrings.viewAll,
                        style: mediumDefault.copyWith(
                          color: ColorResources.conceptTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space40),
                  /* Gift images */
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
                  /* Gifts for the graduate\him\her */
                  Container(
                    height: size.height * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1.15,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.imageGiftCategoryImage.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller
                                            .imageGiftCategoryImage[index],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  controller.giftsForText[index],
                                  textAlign: TextAlign.center,
                                  style: mediumMediumLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  /* POP Card */
                  Text(
                    LocalStrings.planOfPurchase,
                    textAlign: TextAlign.center,
                    style: regularOverLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.24,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffffccff),
                                  Color(0xfffff2ff),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(23),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalStrings.startYourPop,
                                textAlign: TextAlign.start,
                                style: mediumExtraLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.conceptTextColor,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              const Padding(
                                padding: EdgeInsets.only(right: 240),
                                child: Divider(
                                  thickness: 2,
                                  color: ColorResources.conceptTextColor,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                              Text(
                                LocalStrings.aHassleFree,
                                textAlign: TextAlign.start,
                                style: mediumLarge.copyWith(
                                  color: ColorResources.conceptTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space30),
                              Text(
                                LocalStrings.in9Easy,
                                textAlign: TextAlign.start,
                                style: mediumLarge.copyWith(
                                  color: ColorResources.conceptTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Transform.translate(
                            offset: Offset(270, 110),
                            child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.099,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.borderColor
                                        .withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: ColorResources.whiteColor,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: ColorResources.conceptTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      childAspectRatio: 7 / 9.5,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        color: ColorResources.cardBgColor,
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
                  /* Diamond Image */
                  CachedCommonImage(
                    key: const PageStorageKey(
                      'diamond_Image',
                    ),
                    // Add PageStorageKey
                    height: size.height * 0.40,
                    networkImageUrl: MyImages.diamondImage,
                  ),
                  const SizedBox(height: Dimensions.space10),
                  /* Client care */
                  Column(
                    children: [
                      ExpansionTile(
                        backgroundColor: ColorResources.cardBgColor,
                        title: Text(
                          LocalStrings.clientCare,
                          style: mediumLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.add,
                          color: ColorResources.iconColor,
                        ),
                        children: [
                          ListTile(
                            title: Column(
                              children: controller.clientCareList.map((text) {
                                return ListTile(
                                  title: Text(
                                    text,
                                    style: mediumLarge.copyWith(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        backgroundColor: ColorResources.cardBgColor,
                        title: Text(
                          LocalStrings.ourCompany,
                          style: mediumLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.add,
                          color: ColorResources.iconColor,
                        ),
                        children: [
                          ListTile(
                            title: Column(
                              children: controller.ourCompanyList.map((text) {
                                return ListTile(
                                  title: Text(
                                    text,
                                    style: mediumLarge.copyWith(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        backgroundColor: ColorResources.cardBgColor,
                        title: Text(
                          LocalStrings.relatedSite,
                          style: mediumLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.add,
                          color: ColorResources.iconColor,
                        ),
                        children: [
                          ListTile(
                            title: Column(
                              children: controller.relatedSaltAndGlitzSitesList
                                  .map((text) {
                                return ListTile(
                                  title: Text(
                                    text,
                                    style: mediumLarge.copyWith(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space30),
                  Text(
                    LocalStrings.latestSaltAndGlitz,
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
                  /* Email enter textField */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: controller.email,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.defaultRadius),
                        ),
                        hintText: LocalStrings.email,
                        hintStyle: regularLarge.copyWith(
                          color: ColorResources.hintTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space12),
                  /* Signup Button */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 135),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: ColorResources.buttonColorDark,
                          borderRadius:
                              BorderRadius.circular(Dimensions.defaultRadius),
                        ),
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
                  /* Set social media share icon */
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(width: Dimensions.space25),
                      Icon(Icons.face),
                      SizedBox(width: Dimensions.space25),
                      Icon(Icons.web),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

// Function to build the container with an image
  buildContainer(String imageUrl) {
    return Container(
      width: 99, // Fixed width
      height: 140, // Fixed height
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit
              .cover, // To make sure the image covers the entire container
        ),
      ),
    );
  }

  // Bottom sheet User product recently view
  bottomSheetWidget() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final size = MediaQuery.of(context).size;
        return showModalBottomSheet(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          isScrollControlled: true,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.bottomSheetRadius),
              topLeft: Radius.circular(Dimensions.bottomSheetRadius),
            ),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          context: context,
          builder: (context) {
            return Container(
              height: size.height * 0.61,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorResources.scaffoldBackgroundColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.bottomSheetRadius),
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
                            top: 40,
                            left: 15,
                            right: 15,
                          ),
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
                                      // border: Border.all(color: Colors.black),
                                      color: ColorResources
                                          .bottomSheetContainerColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.offersCardRadius),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.offersCardRadius),
                                      child: Image.asset(
                                        controller.products[index]['image'],
                                      ),
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
                                          color: ColorResources.buttonColorDark,
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space2),
                                      Text(
                                        "₹${controller.products[index]['totalCost']}",
                                        style: dateTextStyle.copyWith(
                                          color: ColorResources.buttonColorDark,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
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
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
