import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/core/utils/style.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
import 'package:saltandGlitz/local_storage/pref_manager.dart';
import 'package:saltandGlitz/view/components/cached_image.dart';
import 'package:saltandGlitz/view/components/common_button.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../../../main_controller.dart';
import '../../../notification_services/notification_services.dart';
import '../../components/app_bar_background.dart';
import '../../components/network_connectivity_view.dart';

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
  final categoriesController = Get.put<CategoriesController>(
    CategoriesController(),
  );
  final mainController = Get.put<MainController>(MainController());

  @override
  void initState() {
    super.initState();
    dashboardController.setupScrollListener();
    mainController.checkToAssignNetworkConnections();

    /// Notification initialize
    Get.putAsync(() => NotificationService().init());

    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logHomeView, index: 0);
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
        // Loop through bottomBannerList to handle media playback for all the banners

        // if (Get.arguments != null) {
        //   dashboardController.mediaData = Get.arguments;
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.24,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
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
                padding: EdgeInsets.zero,
              ),
            ],
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
            return mainController.isNetworkConnection?.value == false
                ? NetworkConnectivityView(
                    onTap: () async {
                      RxBool? isEnableNetwork = await mainController
                          .checkToAssignNetworkConnections();
                      if (isEnableNetwork!.value == true) {
                        controller.enableNetworkHideLoader();
                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            Get.put<DashboardController>(
                              DashboardController(),
                            );
                            controller.disableNetworkLoaderByDefault();
                          },
                        );
                        controller.update();
                      }
                    },
                    isLoading: controller.isEnableNetwork,
                  )
                : GestureDetector(
                    onTap: () {
                      controller.hideSearchMethod();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ListView(
                          controller: controller.scrollController,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 9.0),
                              child: CommonTextField(
                                controller: controller.searchTextController,
                                hintText: LocalStrings.search,
                                fillColor: ColorResources.whiteColor,
                                borderColor: ColorResources.buttonColor,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: ColorResources.buttonColor,
                                ),
                                onChange: (value) {
                                  controller.onSearchChanged(value);
                                },
                              ),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            /* category */
                            GetBuilder(
                              init: Get.find<MainController>(),
                              builder: (ctrl) {
                                bool isLoading = categoryList.isEmpty;
                                return Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.15,
                                      child: GridView.builder(
                                        itemCount:
                                            isLoading ? 6 : categoryList.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10.0,
                                          mainAxisExtent: 90,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (isLoading) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Shimmer.fromColors(
                                                baseColor: ColorResources
                                                    .shimmerEffectBaseColor,
                                                highlightColor: ColorResources
                                                    .shimmerEffectHighlightColor,
                                                child: Container(
                                                  height: size.height * 0.12,
                                                  width: size.height * 0.12,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      categoriesController
                                                          .filterCategoriesApiMethod(
                                                              title: categoryList[
                                                                      index]
                                                                  .categoryName);
                                                      Get.toNamed(
                                                          RouteHelper
                                                              .collectionScreen,
                                                          arguments:
                                                              categoryList[
                                                                      index]
                                                                  .categoryName);
                                                    },
                                                    child: CachedNetworkImage(
                                                      height:
                                                          size.height * 0.12,
                                                      width: size.height * 0.12,
                                                      imageUrl:
                                                          categoryList[index]
                                                              .categoryImage!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Shimmer
                                                                  .fromColors(
                                                        baseColor: ColorResources
                                                            .shimmerEffectBaseColor,
                                                        highlightColor:
                                                            ColorResources
                                                                .shimmerEffectHighlightColor,
                                                        child: Container(
                                                          height: size.height *
                                                              0.12,
                                                          width: size.height *
                                                              0.12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  categoryList[index]
                                                          .categoryName ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style: semiBoldDefault
                                                      .copyWith(),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space8),
                            /* Show jewellery products auto loop method */
                            Padding(
                              padding: const EdgeInsets.all(13),
                              child: GetBuilder<MainController>(
                                builder: (ctrl) {
                                  return Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: mediaList.isEmpty
                                            ? Shimmer.fromColors(
                                                baseColor: ColorResources
                                                    .shimmerEffectBaseColor,
                                                highlightColor: ColorResources
                                                    .shimmerEffectHighlightColor,
                                                child: AspectRatio(
                                                  aspectRatio: 0.8,
                                                  child: Container(
                                                    width: double.infinity,
                                                    color: ColorResources
                                                        .whiteColor,
                                                  ),
                                                ),
                                              )
                                            : CarouselSlider.builder(
                                                key: const PageStorageKey(
                                                    'carousel_slider_key'),
                                                itemCount: mediaList.length,
                                                carouselController: controller
                                                    .carouselController,
                                                options: CarouselOptions(
                                                  onPageChanged:
                                                      (index, reason) {
                                                    controller.onPageChanged(
                                                        index, reason);
                                                    controller.currentIndex
                                                        .value = index;
                                                    controller
                                                        .handleMediaPlay(index);
                                                  },
                                                  autoPlay: true,
                                                  enlargeCenterPage: true,
                                                  aspectRatio: 0.8,
                                                  viewportFraction: 1,
                                                ),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index,
                                                        int realIndex) {
                                                  final media =
                                                      mediaList[index];
                                                  final mediaType = media.type;

                                                  if (mediaType ==
                                                      'goldImage') {
                                                    return CachedCommonImage(
                                                      networkImageUrl: media
                                                              .mobileBannerImage ??
                                                          '',
                                                      width: double.infinity,
                                                    );
                                                  } else if (mediaType ==
                                                      'goldVideo') {
                                                    return controller
                                                                .currentIndex
                                                                .value ==
                                                            index
                                                        ? Obx(
                                                            () {
                                                              if (controller
                                                                      .isVideoReady
                                                                      .value &&
                                                                  controller
                                                                          .videoController
                                                                          ?.value
                                                                          .isInitialized ==
                                                                      true) {
                                                                return SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      LayoutBuilder(
                                                                    builder:
                                                                        (context,
                                                                            constraints) {
                                                                      return _buildVideoPlayer(
                                                                          controller
                                                                              .videoController);
                                                                    },
                                                                  ),
                                                                );
                                                              } else {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      ColorResources
                                                                          .shimmerEffectBaseColor,
                                                                  highlightColor:
                                                                      ColorResources
                                                                          .shimmerEffectHighlightColor,
                                                                  child:
                                                                      Container(
                                                                    height: size
                                                                            .height *
                                                                        0.40,
                                                                    width: double
                                                                        .infinity,
                                                                    color: ColorResources
                                                                        .inactiveTabColor,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          )
                                                        : Container();
                                                  }

                                                  return Container(); // Fallback
                                                },
                                              ),
                                      ),
                                      mediaList.isEmpty
                                          ? Shimmer.fromColors(
                                              baseColor: ColorResources
                                                  .shimmerEffectBaseColor,
                                              highlightColor: ColorResources
                                                  .shimmerEffectHighlightColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  5,
                                                  (i) => const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 15),
                                                    child: CircleAvatar(
                                                      radius: 3.5,
                                                      backgroundColor:
                                                          ColorResources
                                                              .whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  mediaList.length,
                                                  (i) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 7,
                                                        vertical: 15),
                                                    child: CircleAvatar(
                                                      radius: 3.5,
                                                      backgroundColor: controller
                                                                  .currentIndex
                                                                  .value ==
                                                              i
                                                          ? ColorResources
                                                              .activeCardColor
                                                          : ColorResources
                                                              .inactiveCardColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: Dimensions.space30),
                            /* Banner images */
                            bottomBannerList.isEmpty
                                ? const SizedBox()
                                : GetBuilder(
                                    init: MainController(),
                                    builder: (ctrl) {
                                      String? media = bottomBannerList[0]
                                          .bannerImage; // Get the media URL
                                      // Trigger the media playback for this index
                                      dashboardController.handleMediaPlayback(
                                          media: media!, index: 0);
                                      // bool isLoading = bottomBannerList.isEmpty;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: bottomBannerList.isEmpty
                                              ? Shimmer.fromColors(
                                                  baseColor: ColorResources
                                                      .shimmerEffectBaseColor,
                                                  highlightColor: ColorResources
                                                      .shimmerEffectHighlightColor,
                                                  child: Container(
                                                    height: size.height * 0.46,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: size.height * 0.46,
                                                  child: LayoutBuilder(
                                                    builder:
                                                        (context, constraints) {
                                                      // Ensure the video player is only built once the layout is done
                                                      return _buildVideoPlayer(
                                                          dashboardController
                                                              .videoControllers[0]);
                                                    },
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                            const SizedBox(height: Dimensions.space10),
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty ||
                                //     bottomBannerList.length < 2;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.23,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'summer_Rings_Image'),
                                            height: size.height * 0.23,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[1].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space10),
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty ||
                                //     bottomBannerList.length < 2;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.23,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'summer_Rings_Image'),
                                            height: size.height * 0.23,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[2].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space50),
                            /* The Salt Promise */
                            Text(
                              LocalStrings.saltPromise,
                              textAlign: TextAlign.center,
                              style: regularOverLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Dimensions.space15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Container(
                                height: size.height * 0.15,
                                width: size.width * double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFe1f1ea),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Even spacing
                                    children: [
                                      GetBuilder(
                                        init: DashboardController(),
                                        builder: (controller) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    controller.iconImagesList[
                                                        0], // Use the list dynamically
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space5),
                                              Text(
                                                LocalStrings.easyReturns,
                                                textAlign: TextAlign.center,
                                                style: mediumSmall.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      GetBuilder(
                                        init: DashboardController(),
                                        builder: (controller) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    controller
                                                        .iconImagesList[1],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space5),
                                              Text(
                                                LocalStrings.oneYearWarranty,
                                                textAlign: TextAlign.center,
                                                style: mediumSmall.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      GetBuilder(
                                        init: DashboardController(),
                                        builder: (controller) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    controller
                                                        .iconImagesList[2],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space5),
                                              Text(
                                                LocalStrings.hundredCertified,
                                                textAlign: TextAlign.center,
                                                style: mediumSmall.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      GetBuilder(
                                        init: DashboardController(),
                                        builder: (controller) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    controller
                                                        .iconImagesList[3],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space5),
                                              Text(
                                                LocalStrings.lifeTimeExchange,
                                                textAlign: TextAlign.center,
                                                style: mediumSmall.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space40),
                            /* Curated Only For */
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Container(
                                height: size.height * 0.6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFe1f1ea),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: Dimensions.space20),
                                    Text(
                                      LocalStrings.exclusiveDeals,
                                      textAlign: TextAlign.center,
                                      style: regularSmall.copyWith(),
                                    ),
                                    Text(
                                      LocalStrings.curatedOnlyForYou,
                                      textAlign: TextAlign.center,
                                      style: regularOverLarge.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: Dimensions.space10),

                                    // === GridView (Shimmer or Items) ===
                                    GetBuilder(
                                      init: MainController(),
                                      builder: (ctrl) {
                                        final isLoading =
                                            newArrivalList.isEmpty;

                                        return SizedBox(
                                          height: size.height * 0.39,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 1,
                                                childAspectRatio: 1.4,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: isLoading
                                                  ? 6
                                                  : newArrivalList.length,
                                              itemBuilder: (context, index) {
                                                if (isLoading) {
                                                  // Shimmer placeholder
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor: ColorResources
                                                              .shimmerEffectBaseColor,
                                                          highlightColor:
                                                              ColorResources
                                                                  .shimmerEffectHighlightColor,
                                                          child: Container(
                                                            height:
                                                                size.height *
                                                                    0.28,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space5),
                                                        Shimmer.fromColors(
                                                          baseColor: ColorResources
                                                              .shimmerEffectBaseColor,
                                                          highlightColor:
                                                              ColorResources
                                                                  .shimmerEffectHighlightColor,
                                                          child: Container(
                                                            height: 12,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space5),
                                                        Shimmer.fromColors(
                                                          baseColor: ColorResources
                                                              .shimmerEffectBaseColor,
                                                          highlightColor:
                                                              ColorResources
                                                                  .shimmerEffectHighlightColor,
                                                          child: Container(
                                                            height: 12,
                                                            width: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  // Actual content
                                                  final item =
                                                      newArrivalList[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          RouteHelper
                                                              .productScreen,
                                                          arguments: [item, 0],
                                                        );
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  CachedCommonImage(
                                                                networkImageUrl:
                                                                    item
                                                                        .media![
                                                                            0]
                                                                        .productAsset,
                                                                height:
                                                                    size.height *
                                                                        0.28,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height:
                                                                    Dimensions
                                                                        .space5),
                                                            Text(
                                                              item.category ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: mediumLarge
                                                                  .copyWith(
                                                                color: ColorResources
                                                                    .buttonColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              "₹${item.price14KT?.round()}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: mediumLarge
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: ColorResources
                                                                    .buttonColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(height: Dimensions.space8),

                                    // === View All Button ===
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 120.0),
                                      child: CommonButton(
                                        onTap: () {
                                          categoriesController
                                              .filterCategoriesApiMethod(
                                                  priceOrder: 'newestFirst');
                                          Get.toNamed(
                                              RouteHelper.collectionScreen);
                                        },
                                        gradientFirstColor:
                                            ColorResources.whiteColor,
                                        gradientSecondColor:
                                            ColorResources.whiteColor,
                                        borderColor: ColorResources.buttonColor,
                                        height: size.height * 0.05,
                                        child: Text(
                                          LocalStrings.viewAll,
                                          style: mediumDefault.copyWith(
                                            color: ColorResources.buttonColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space30),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: Dimensions.space20),
                            /* Banner images */
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                String? media = bottomBannerList[3].bannerImage;
                                dashboardController.handleMediaPlayback(
                                    media: media!,
                                    index:
                                        3); // bool isLoading = bottomBannerList.isEmpty;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.46,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: size.height * 0.46,
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                // Ensure the video player is only built once the layout is done
                                                return _buildVideoPlayer(
                                                  dashboardController
                                                      .videoControllers[3],
                                                );
                                              },
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space10),
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty ||
                                //     bottomBannerList.length < 2;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.23,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'summer_Rings_Image'),
                                            height: size.height * 0.23,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[4].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space10),
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty ||
                                //     bottomBannerList.length < 2;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.23,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'summer_Rings_Image'),
                                            height: size.height * 0.23,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[5].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space40),
                            /* Wrapped with love */
                            Text(
                              LocalStrings.wrappedWithLove,
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
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                bool isLoading = filterCategoryList.isEmpty;
                                return Column(
                                  children: List.generate(
                                    2,
                                    (rowIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                            3,
                                            (index) {
                                              int itemIndex =
                                                  rowIndex * 3 + index;

                                              // Show shimmer when loading
                                              if (isLoading) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .shimmerEffectBaseColor,
                                                      highlightColor: ColorResources
                                                          .shimmerEffectHighlightColor,
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .shimmerEffectBaseColor,
                                                      highlightColor: ColorResources
                                                          .shimmerEffectHighlightColor,
                                                      child: Container(
                                                        height: 12,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              // If index exceeds list length
                                              if (itemIndex >=
                                                  filterCategoryList.length) {
                                                return const SizedBox();
                                              }
                                              var item =
                                                  filterCategoryList[itemIndex];
                                              return GestureDetector(
                                                onTap: () {
                                                  categoriesController
                                                      .filterCategoriesApiMethod(
                                                    wrappedBy:
                                                        item.filterCategoryName,
                                                  );
                                                  Get.toNamed(RouteHelper
                                                      .collectionScreen);
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: CachedCommonImage(
                                                        networkImageUrl:
                                                            item.filterCategoryImage ??
                                                                '',
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      item.filterCategoryName ??
                                                          '',
                                                      style:
                                                          regularSmall.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space40),
                            /* Banner Image */
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.33,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'silver_Gifts_Image'),
                                            // height: size.height * 0.3,
                                            height: size.height * 0.6,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[7].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space40),
                            /* Gifts for the graduate\him\her */
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                bool isLoading = giftElementList
                                    .isEmpty; // Check if the list is empty

                                return Container(
                                  height: size.height *
                                      0.51, // Increased overall height
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13.0),
                                    child: giftElementList.isEmpty
                                        // Show shimmer effect when list is empty
                                        ? GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 1,
                                              childAspectRatio: 1.3,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .shimmerEffectBaseColor,
                                                      highlightColor: ColorResources
                                                          .shimmerEffectHighlightColor,
                                                      child: Container(
                                                        height:
                                                            330, // Increased from 300
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            Dimensions.space5),
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .shimmerEffectBaseColor,
                                                      highlightColor: ColorResources
                                                          .shimmerEffectHighlightColor,
                                                      child: Container(
                                                        height: 16,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        // Display actual items when list is not empty
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 1,
                                              childAspectRatio: 1.3,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: giftElementList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    categoriesController
                                                        .filterCategoriesApiMethod(
                                                      giftFor:
                                                          giftElementList[index]
                                                              .giftName,
                                                    );
                                                    Get.toNamed(RouteHelper
                                                        .collectionScreen);
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.45,
                                                        width: double.infinity,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: giftElementList[
                                                                              index]
                                                                          .type ==
                                                                      "goldImage"
                                                                  ? CachedCommonImage(
                                                                      networkImageUrl:
                                                                          giftElementList[index]
                                                                              .giftImage,
                                                                      width: double
                                                                          .infinity,
                                                                    )
                                                                  : VisibilityDetector(
                                                                      key: Key(
                                                                          "video_$index"),
                                                                      onVisibilityChanged:
                                                                          (info) {
                                                                        if (info.visibleFraction >
                                                                            0.5) {
                                                                          controller
                                                                              .handleMediaPlayback(
                                                                            media:
                                                                                giftElementList[index].giftImage ?? "",
                                                                            index:
                                                                                index,
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Obx(
                                                                        () {
                                                                          bool
                                                                              isReady =
                                                                              controller.isVideoReadyList.length > index && controller.isVideoReadyList[index] == true;
                                                                          var videoController = controller.videoControllers.length > index
                                                                              ? controller.videoControllers[index]
                                                                              : null;

                                                                          if (isReady &&
                                                                              videoController != null &&
                                                                              videoController.value.isInitialized) {
                                                                            return _buildVideoPlayer(videoController);
                                                                          } else {
                                                                            return Shimmer.fromColors(
                                                                              baseColor: ColorResources.shimmerEffectBaseColor,
                                                                              highlightColor: ColorResources.shimmerEffectHighlightColor,
                                                                              child: Container(
                                                                                height: size.height * 0.30,
                                                                                width: double.infinity,
                                                                                color: ColorResources.inactiveTabColor,
                                                                              ),
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space5),
                                                      Expanded(
                                                        child: Text(
                                                          giftElementList[index]
                                                                  .giftName ??
                                                              '',
                                                          maxLines: 2,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: mediumLarge
                                                              .copyWith(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: Dimensions.space20),
                            /* Banner images */
                            GetBuilder(
                              init: MainController(),
                              builder: (ctrl) {
                                // bool isLoading = bottomBannerList.isEmpty;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    child: bottomBannerList.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: ColorResources
                                                .shimmerEffectBaseColor,
                                            highlightColor: ColorResources
                                                .shimmerEffectHighlightColor,
                                            child: Container(
                                              height: size.height * 0.52,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                            ),
                                          )
                                        : CachedCommonImage(
                                            key: const PageStorageKey(
                                                'silver_Gifts_Image'),
                                            height: size.height * 0.52,
                                            width: double.infinity,
                                            networkImageUrl:
                                                bottomBannerList[9].bannerImage,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space40),
                            const Divider(
                              color: ColorResources.buttonColor,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: Dimensions.space20),
                            /* POP Card */
                            // Text(
                            //   LocalStrings.planOfPurchase,
                            //   textAlign: TextAlign.center,
                            //   style: regularOverLarge.copyWith(
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // const SizedBox(height: Dimensions.space10),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 16, right: 16),
                            //   child: Stack(
                            //     children: [
                            //       Container(
                            //         height: size.height * 0.24,
                            //         decoration: BoxDecoration(
                            //             gradient: const LinearGradient(
                            //               colors: [
                            //                 Color(0xffffccff),
                            //                 Color(0xfffff2ff),
                            //               ],
                            //             ),
                            //             borderRadius: BorderRadius.circular(23),
                            //             boxShadow: [
                            //               BoxShadow(
                            //                 color: Colors.grey.shade500,
                            //                 blurRadius: 8,
                            //                 spreadRadius: 0,
                            //                 offset: const Offset(0, 3),
                            //               ),
                            //             ]),
                            //         padding: const EdgeInsets.all(17),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               LocalStrings.startYourPop,
                            //               textAlign: TextAlign.start,
                            //               style: mediumExtraLarge.copyWith(
                            //                 fontWeight: FontWeight.bold,
                            //                 color:
                            //                     ColorResources.buttonColor,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //                 height: Dimensions.space10),
                            //             const Padding(
                            //               padding: EdgeInsets.only(right: 240),
                            //               child: Divider(
                            //                 thickness: 2,
                            //                 color:
                            //                     ColorResources.buttonColor,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //                 height: Dimensions.space5),
                            //             Text(
                            //               LocalStrings.aHassleFree,
                            //               textAlign: TextAlign.start,
                            //               style: mediumLarge.copyWith(
                            //                 color:
                            //                     ColorResources.buttonColor,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //                 height: Dimensions.space30),
                            //             Text(
                            //               LocalStrings.in9Easy,
                            //               textAlign: TextAlign.start,
                            //               style: mediumLarge.copyWith(
                            //                 color:
                            //                     ColorResources.buttonColor,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Positioned(
                            //         child: Transform.translate(
                            //           offset: const Offset(270, 110),
                            //           child: Container(
                            //             height: size.height * 0.1,
                            //             width: size.width * 0.099,
                            //             decoration: BoxDecoration(
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                   color: ColorResources.borderColor
                            //                       .withOpacity(0.1),
                            //                   spreadRadius: 3,
                            //                   blurRadius: 2,
                            //                   offset: const Offset(0, 2),
                            //                 ),
                            //               ],
                            //               shape: BoxShape.circle,
                            //               color: ColorResources.whiteColor,
                            //             ),
                            //             child: const Icon(
                            //               Icons.arrow_forward_rounded,
                            //               color:
                            //                   ColorResources.buttonColor,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(height: Dimensions.space35),
                            // GridView.builder(
                            //   itemCount: controller.servicesTitleText.length,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   shrinkWrap: true,
                            //   gridDelegate:
                            //       const SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: 2,
                            //     crossAxisSpacing: 22.0,
                            //     childAspectRatio: 7 / 9.5,
                            //   ),
                            //   itemBuilder: (context, index) {
                            //     return Card(
                            //       color: ColorResources.cardBgColor,
                            //       child: Center(
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             const Spacer(),
                            //             Icon(controller.iconList[index]),
                            //             const SizedBox(
                            //                 height: Dimensions.space20),
                            //             Text(
                            //               controller.servicesTitleText[index],
                            //               textAlign: TextAlign.center,
                            //               style: semiBoldLarge.copyWith(),
                            //             ),
                            //             const SizedBox(
                            //                 height: Dimensions.space10),
                            //             Text(
                            //               controller
                            //                   .servicesSubTitleText[index],
                            //               textAlign: TextAlign.center,
                            //               style: regularSmall.copyWith(),
                            //             ),
                            //             const Spacer(),
                            //             Text(
                            //               controller.servicesText[index],
                            //               textAlign: TextAlign.center,
                            //               style: semiBoldSmall.copyWith(),
                            //             ),
                            //             const SizedBox(
                            //                 height: Dimensions.space10),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            // const SizedBox(height: Dimensions.space30),
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
                                  trailing: const Icon(
                                    Icons.add,
                                    color: ColorResources.iconColor,
                                  ),
                                  children: [
                                    ListTile(
                                      title: Column(
                                        children: controller.clientCareList.map(
                                          (text) {
                                            return ListTile(
                                              title: Text(
                                                text,
                                                style: mediumLarge.copyWith(),
                                              ),
                                            );
                                          },
                                        ).toList(),
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
                                  trailing: const Icon(
                                    Icons.add,
                                    color: ColorResources.iconColor,
                                  ),
                                  children: [
                                    ListTile(
                                      title: Column(
                                        children: controller.ourCompanyList.map(
                                          (text) {
                                            return ListTile(
                                              title: Text(
                                                text,
                                                style: mediumLarge.copyWith(),
                                              ),
                                            );
                                          },
                                        ).toList(),
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
                                  trailing: const Icon(
                                    Icons.add,
                                    color: ColorResources.iconColor,
                                  ),
                                  children: [
                                    ListTile(
                                      selectedColor: ColorResources.buttonColor,
                                      title: Column(
                                        children: controller
                                            .relatedSaltAndGlitzSitesList
                                            .map(
                                          (text) {
                                            return ListTile(
                                              title: Text(
                                                text,
                                                style: mediumLarge.copyWith(),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                ExpansionTile(
                                  backgroundColor: ColorResources.cardBgColor,
                                  title: Text(
                                    LocalStrings.latestFromSalt,
                                    style: mediumLarge.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: const Icon(
                                    Icons.add,
                                    color: ColorResources.iconColor,
                                  ),
                                  children: [
                                    const SizedBox(height: Dimensions.space10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        LocalStrings.knowAbout,
                                        textAlign: TextAlign.center,
                                        style: regularLarge.copyWith(),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: TextField(
                                        controller: controller.email,
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.defaultRadius),
                                          ),
                                          hintText: LocalStrings.email,
                                          hintStyle: regularLarge.copyWith(
                                            color: ColorResources.hintTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 135),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color:
                                                ColorResources.buttonColorDark,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.defaultRadius),
                                          ),
                                          child: Center(
                                            child: Text(
                                              LocalStrings.signUp,
                                              textAlign: TextAlign.center,
                                              style: semiBoldLarge.copyWith(
                                                color: ColorResources
                                                    .inactiveCardColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.space30),
                            // Text(
                            //   LocalStrings.latestSaltAndGlitz,
                            //   textAlign: TextAlign.center,
                            //   style: semiBoldLarge.copyWith(),
                            // ),
                            // const SizedBox(height: Dimensions.space20),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text(
                            //     LocalStrings.knowAbout,
                            //     textAlign: TextAlign.center,
                            //     style: regularLarge.copyWith(),
                            //   ),
                            // ),
                            // const SizedBox(height: Dimensions.space20),
                            // /* Email enter textField */
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20),
                            //   child: TextField(
                            //     controller: controller.email,
                            //     textInputAction: TextInputAction.done,
                            //     keyboardType: TextInputType.emailAddress,
                            //     decoration: InputDecoration(
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(
                            //             Dimensions.defaultRadius),
                            //       ),
                            //       hintText: LocalStrings.email,
                            //       hintStyle: regularLarge.copyWith(
                            //         color: ColorResources.hintTextColor,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: Dimensions.space12),
                            // /* Signup Button */
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 135),
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: Container(
                            //       height: 45,
                            //       decoration: BoxDecoration(
                            //         color: ColorResources.buttonColorDark,
                            //         borderRadius: BorderRadius.circular(
                            //             Dimensions.defaultRadius),
                            //       ),
                            //       child: Center(
                            //         child: Text(
                            //           LocalStrings.signUp,
                            //           textAlign: TextAlign.center,
                            //           style: semiBoldLarge.copyWith(
                            //             color: ColorResources.inactiveCardColor,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: Dimensions.space20),
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
                        //Todo : Overlay search Box
                        Obx(
                          () => controller.isDialogVisible.value
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.090),
                                  child: Container(
                                    height: controller.searchProducts.length < 3
                                        ? size.height * 0.17
                                        : (controller.searchProducts.length >
                                                    3 &&
                                                controller
                                                        .searchProducts.length <
                                                    6)
                                            ? size.height * 0.33
                                            : size.height * 0.40,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorResources.whiteColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              ColorResources.inactiveTabColor,
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.defaultRadius),
                                    ),
                                    child: controller.isSearchShimmer.value ==
                                            true
                                        ? GridView.builder(
                                            itemCount: 9,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 11.0,
                                              mainAxisSpacing: 15.0,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: ColorResources
                                                      .shimmerEffectBaseColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .defaultRadius),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: ColorResources
                                                          .inactiveTabColor,
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .baseColor,
                                                      highlightColor:
                                                          ColorResources
                                                              .highlightColor,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft: Radius
                                                              .circular(Dimensions
                                                                  .defaultRadius),
                                                          topRight: Radius
                                                              .circular(Dimensions
                                                                  .defaultRadius),
                                                        ),
                                                        child: Container(
                                                          height: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                ColorResources
                                                                    .whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .baseColor,
                                                      highlightColor:
                                                          ColorResources
                                                              .highlightColor,
                                                      child: Container(
                                                        height:
                                                            size.height * 0.015,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : controller.searchProducts.isEmpty
                                            ? Center(
                                                child: Text(
                                                  LocalStrings
                                                      .searchNotAvailable,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: semiBoldSmall.copyWith(
                                                    color: ColorResources
                                                        .buttonColor,
                                                  ),
                                                ),
                                              )
                                            : GridView.builder(
                                                itemCount: controller
                                                    .searchProducts.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 11.0,
                                                  mainAxisSpacing: 15.0,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .shimmerEffectBaseColor,
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .defaultRadius),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: ColorResources
                                                              .inactiveTabColor,
                                                          offset: Offset(0, 1),
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(RouteHelper
                                                            .collectionScreen);
                                                        categoriesController
                                                            .filterCategoriesApiMethod(
                                                                occasionBy: controller
                                                                    .searchProducts[
                                                                        index]
                                                                    .subCategory,
                                                                priceLimit: '');
                                                        controller
                                                            .hideSearchMethod();
                                                        //Todo : Search box hide
                                                        controller
                                                            .isDialogVisible
                                                            .value = false;
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .defaultRadius),
                                                              topRight: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .defaultRadius),
                                                            ),
                                                            child:
                                                                CachedCommonImage(
                                                              networkImageUrl:
                                                                  controller
                                                                      .searchProducts[
                                                                          index]
                                                                      .image01,
                                                              // categoryList[index]
                                                              //         .images,
                                                              width: double
                                                                  .infinity,
                                                              height: 100,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          5),
                                                              child: Text(
                                                                controller
                                                                        .searchProducts[
                                                                            index]
                                                                        .title ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style:
                                                                    semiBoldSmall
                                                                        .copyWith(
                                                                  color: ColorResources
                                                                      .buttonColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                    // Center(
                                    //   child: Text(
                                    //     'Search Results',
                                    //     style: TextStyle(
                                    //         color: Colors.black, fontSize: 18),
                                    //   ),
                                    // ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
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
    AppAnalytics().actionTriggerLogs(
        eventName: LocalStrings.logHomeRecentProductView, index: 0);
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
              height: size.height * 0.50,
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
                    color: ColorResources.lightGreenColour,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.space10),
                        Container(
                          height: 5,
                          width: 40,
                          color: ColorResources.whiteColor,
                        ),
                        const SizedBox(height: Dimensions.space20),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space20),
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
                                color: ColorResources.buttonColor,
                              ),
                            ),
                            Text(
                              "${PrefManager.getString("firstName")} ${PrefManager.getString("lastName")}",
                              style: semiBoldMediumLarge.copyWith(
                                color: ColorResources.buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space3),
                  Text(
                    LocalStrings.yourRecentlyViewedProducts,
                    style: semiBoldMediumLarge.copyWith(
                      color: ColorResources.buttonColor,
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
                            return GestureDetector(
                              child: Padding(
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
                                        child: CachedCommonImage(
                                          networkImageUrl: controller
                                              .products[index]['image'],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                    Text(
                                      controller.products[index]['name'],
                                      style: regularDefault.copyWith(
                                          color:
                                              ColorResources.buttonColorDark),
                                    ),
                                    const SizedBox(height: Dimensions.space1),
                                    Text(
                                      "₹${controller.products[index]['totalCost']}",
                                      style: mediumDefault.copyWith(
                                        color: ColorResources.buttonColorDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
//
// Widget VideoPlayerWidget({
//   required String videoUrl,
//   required double height,
//   required double width,
// }) {
//   return FutureBuilder<VideoPlayerController>(
//     future: _initializeController(videoUrl),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Shimmer.fromColors(
//           baseColor: ColorResources.shimmerEffectBaseColor,
//           highlightColor: ColorResources.shimmerEffectHighlightColor,
//           child: Container(
//             height: height,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: ColorResources.whiteColor,
//               borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
//             ),
//           ),
//         );
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error loading video'));
//       } else {
//         final controller = snapshot.data!;
//         controller.play();
//         controller.setLooping(true);
//
//         return SizedBox(
//           height: height,
//           width: width,
//           child: AspectRatio(
//             aspectRatio: controller.value.aspectRatio,
//             child: VideoPlayer(controller),
//           ),
//         );
//       }
//     },
//   );
// }

// Future<VideoPlayerController> _initializeController(String videoUrl) async {
//   final controller = VideoPlayerController.network(videoUrl);
//   await controller.initialize();
//   return controller;
// }

Widget _buildVideoPlayer(VideoPlayerController? controller) {
  if (controller == null || !controller.value.isInitialized) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: ColorResources.shimmerEffectBaseColor,
        highlightColor: ColorResources.shimmerEffectHighlightColor,
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorResources.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
          ),
        ),
      ),
    );
  }
  return AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  ); // Return the video player widget once it's initialized
}
