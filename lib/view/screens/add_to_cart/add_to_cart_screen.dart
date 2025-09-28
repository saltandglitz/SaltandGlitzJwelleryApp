import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:saltandglitz/core/utils/images.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/data/controller/add_to_cart/add_to_cart_controller.dart';
import 'package:saltandglitz/data/controller/collection/collection_controller.dart';
import 'package:saltandglitz/view/components/common_button.dart';
import 'package:saltandglitz/view/components/common_message_show.dart';
import 'package:shimmer/shimmer.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/product/product_controller.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';
import '../../components/network_connectivity_view.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final addCartController = Get.put<AddToCartController>(AddToCartController());
  final mainController = Get.put<MainController>(MainController());
  List<String>? wishlistData;
  String _formattedDeliveryDate() {
    DateTime date = DateTime.now().add(const Duration(days: 17));
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }

  @override
  void initState() {
    mainController.checkToAssignNetworkConnections();
    addCartController.implementAnimationOffersMethod();
    addCartController.getCartDataApiMethod();
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logAddCartView, index: 4);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addCartController.timer!.cancel();
    super.dispose();
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
          title: Text(LocalStrings.shoppingCart),
          titleTextStyle: regularLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorResources.buttonColor,
          ),
          leading: IconButton(
            onPressed: () {
              mainController.checkToAssignNetworkConnections();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: ColorResources.buttonColor,
          ),

          backgroundColor: ColorResources.whiteColor,
          // Set the background color of the AppBar
          elevation: 0, // Remove default shadow
        ),
      ),
      bottomSheet: Container(
        height: size.height * 0.080,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: ColorResources.whiteColor,
          boxShadow: [
            BoxShadow(
              color: ColorResources.borderColor,
              offset: Offset(0, 1),
              // Position the shadow below the AppBar
              blurRadius: 2, // Adjust the blur radius as needed
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder(
                  init: AddToCartController(),
                  builder: (controller) {
                    return controller.isGetCartData.value == true
                        ? Shimmer.fromColors(
                            baseColor: ColorResources.baseColor,
                            highlightColor: ColorResources.highlightColor,
                            child: Container(
                              height: 13,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.minimumRadius),
                                color: ColorResources.highlightColor,
                              ),
                            ),
                          )
                        : Text(
                            "₹${controller.calculateTotalPrice().round()}",
                            style: boldMediumLarge.copyWith(
                              color: ColorResources.buttonColor,
                            ),
                          );
                  },
                ),
                Text(
                  LocalStrings.viewOrder,
                  style: boldSmall.copyWith(
                    color: ColorResources.offerColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Common Place order button
            CommonButton(
              onTap: () {
                //Todo : If users not login this time show this snackBar message
                if (PrefManager.getString('isLogin') == null ||
                    PrefManager.getString('isLogin') != "yes") {
                  showSnackBar(
                    context: context,
                    title: "Error",
                    message: LocalStrings.pleaseLogin,
                    icon: Icons.error,
                    iconColor: Colors.red,
                  );
                } else {
                  Get.toNamed(RouteHelper.placeOrder,
                      arguments:
                          addCartController.getAddCartData?.cart?.cartId);
                }
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<AddToCartController>(
        init: AddToCartController(),
        builder: (controller) {
          return mainController.isNetworkConnection?.value == false
              ? NetworkConnectivityView(
                  onTap: () async {
                    RxBool? isEnableNetwork =
                        await mainController.checkToAssignNetworkConnections();

                    if (isEnableNetwork!.value == true) {
                      controller.enableNetworkHideLoader();
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          Get.put<AddToCartController>(AddToCartController());
                          controller.disableNetworkLoaderByDefault();
                        },
                      );
                      controller.update();
                    }
                  },
                  isLoading: controller.isEnableNetwork,
                )
              : SafeArea(
                  top: false,
                  bottom: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.space10),
                        SizedBox(
                            height:
                                (controller.getAddCartData?.cart!.quantity ==
                                            null ||
                                        controller.getAddCartData?.cart!
                                                .quantity!.isEmpty ==
                                            true)
                                    ? Dimensions.space50
                                    : Dimensions.space15),
                        controller.isGetCartData.value == true
                            ? wishlistProductsShimmerEffect(controller)
                            : (controller.getAddCartData?.cart!.quantity ==
                                        null ||
                                    controller.getAddCartData?.cart!.quantity!
                                            .isEmpty ==
                                        true)
                                ? Center(
                                    child: Text(
                                      LocalStrings.addToCartEmpty,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: mediumLarge.copyWith(),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: controller
                                        .getAddCartData?.cart?.quantity?.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 17),
                                        decoration: BoxDecoration(
                                          color: ColorResources.cardBgColor,
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.offersCardRadius,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorResources.borderColor
                                                  .withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: size.height * 0.11,
                                              width: size.width * 0.22,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorResources
                                                      .lightGreenColour,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.offersCardRadius,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.offersCardRadius,
                                                ),
                                                child: CachedCommonImage(
                                                  width: double.infinity,
                                                  networkImageUrl: controller
                                                      .getAddCartData
                                                      ?.cart
                                                      ?.quantity?[index]
                                                      .productId
                                                      ?.image01,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.space20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          controller
                                                                  .getAddCartData
                                                                  ?.cart
                                                                  ?.quantity?[
                                                                      index]
                                                                  .productId
                                                                  ?.title ??
                                                              '',
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: mediumSmall
                                                              .copyWith(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "₹${(controller.getItemPrice(controller.getAddCartData?.cart?.quantity?[index]) * (controller.getAddCartData?.cart?.quantity?[index].quantity ?? 1)).round()}",
                                                    style: boldSmall.copyWith(
                                                      color: ColorResources
                                                          .buttonColor,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space15),
                                                  // controller.isQuantity![index].value =   getAddCartData?.cart?.quantity?[index].quantity?.toInt()??0;

                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${LocalStrings.quantity} ',
                                                        style:
                                                            boldSmall.copyWith(
                                                          color: ColorResources
                                                              .buttonColor,
                                                        ),
                                                      ),
                                                      //Todo : + , - & quantity set and size set only ring & bracelet
                                                      RichText(
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: '+ ',
                                                                  style: semiBoldLarge
                                                                      .copyWith(
                                                                    color: ColorResources
                                                                        .buttonColor,
                                                                  ),
                                                                  recognizer:
                                                                      TapGestureRecognizer()
                                                                        ..onTap =
                                                                            () {
                                                                          //Todo : incrementProductApiMethod using product quantity increment
                                                                          controller
                                                                              .incrementProductApiMethod(
                                                                            cartId:
                                                                                "${controller.getAddCartData?.cart!.cartId}",
                                                                            productId:
                                                                                "${controller.getAddCartData?.cart?.quantity?[index].productId!.productId}",
                                                                            productSize:
                                                                                controller.getAddCartData?.cart?.quantity?[index].size,
                                                                            carat:
                                                                                controller.getAddCartData?.cart?.quantity?[index].caratBy,
                                                                            colorJewellery:
                                                                                controller.getAddCartData?.cart?.quantity?[index].colorBy,
                                                                            index:
                                                                                index,
                                                                          );
                                                                        }),
                                                              TextSpan(
                                                                text:
                                                                    "${controller.getAddCartData?.cart?.quantity?[index].quantity}",
                                                                style:
                                                                    semiBoldLarge
                                                                        .copyWith(
                                                                  color: ColorResources
                                                                      .buttonColor,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  text: ' -',
                                                                  style: semiBoldLarge
                                                                      .copyWith(
                                                                    color: ColorResources
                                                                        .buttonColor,
                                                                  ),
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = controller.getAddCartData?.cart?.quantity?[index].quantity == 1
                                                                        ? null
                                                                        : () {
                                                                            //Todo : incrementProductApiMethod using product quantity increment
                                                                            controller.decrementProductApiMethod(
                                                                              cartId: "${controller.getAddCartData?.cart!.cartId}",
                                                                              productId: "${controller.getAddCartData?.cart?.quantity?[index].productId!.productId}",
                                                                              productSize: controller.getAddCartData?.cart?.quantity?[index].size,
                                                                              carat: controller.getAddCartData?.cart?.quantity?[index].caratBy,
                                                                              colorJewellery: controller.getAddCartData?.cart?.quantity?[index].colorBy,
                                                                              index: index,
                                                                            );
                                                                          }),
                                                            ]),
                                                      ),

                                                      const SizedBox(
                                                          width: Dimensions
                                                              .space20),
                                                      Text(
                                                        '${LocalStrings.size} ',
                                                        style:
                                                            boldSmall.copyWith(
                                                          color: ColorResources
                                                              .buttonColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${controller.getAddCartData?.cart?.quantity?[index].size}",
                                                        style: semiBoldLarge
                                                            .copyWith(
                                                          color: ColorResources
                                                              .buttonColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space5),
                                                  Text(
                                                    "ESTIMATED DELIVERY BY ${_formattedDeliveryDate()}",
                                                    style: mediumExtraSmall
                                                        .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: ColorResources
                                                          .offerColor
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // bottomSheetWidget(
                                                //   controller.productsImage[index],
                                                //   controller.productsName[index],
                                                //   controller,
                                                //   index,
                                                // );
                                                //Todo : Remove particular add to cart products
                                                /*controller.removeCartApiMethod(
                                                itemId: controller.getAddCartData
                                                    ?.cart
                                                    ?.quantity?[index]!
                                                    .productId
                                                    ?.productId);
                                            */
                                                bottomSheetWidget(
                                                    controller
                                                            .getAddCartData
                                                            ?.cart
                                                            ?.quantity?[index]
                                                            .productId
                                                            ?.image01 ??
                                                        '',
                                                    controller
                                                            .getAddCartData
                                                            ?.cart
                                                            ?.quantity?[index]
                                                            .productId
                                                            ?.title ??
                                                        '',
                                                    controller,
                                                    index,
                                                    controller
                                                        .getAddCartData
                                                        ?.cart
                                                        ?.quantity?[index]
                                                        .productId
                                                        ?.productId);
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorResources
                                                        .buttonColor),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 15,
                                                  color:
                                                      ColorResources.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                        SizedBox(
                            height:
                                (controller.getAddCartData?.cart!.quantity ==
                                            null ||
                                        controller.getAddCartData?.cart!
                                                .quantity!.isEmpty ==
                                            true)
                                    ? Dimensions.space50
                                    : Dimensions.space10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LocalStrings.offersBenefits,
                            style: semiBoldDefault.copyWith(),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space10),
                        GestureDetector(
                          onTap: () {
                            AppAnalytics().actionTriggerLogs(
                                eventName:
                                    LocalStrings.logAddCartApplyCouponClick,
                                index: 4);
                          },
                          child: Container(
                            height: size.height * 0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius),
                              color: ColorResources.lightGreenColour,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor
                                      .withOpacity(0.3),
                                  offset: const Offset(0, 5),
                                  blurRadius:
                                      5, // Adjust the blur radius as needed
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      MyImages.discountImage,
                                      color: ColorResources.blackColor,
                                      height: 25,
                                      width: 25,
                                    ),
                                    const SizedBox(width: Dimensions.space10),
                                    Text(
                                      LocalStrings.applyCoupon,
                                      style: boldLarge.copyWith(
                                        color: ColorResources.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              ColorResources.lightGreenColour,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorResources.borderColor,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_forward_rounded,
                                            color: ColorResources.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space23),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LocalStrings.oderSummary,
                            style: semiBoldDefault.copyWith(),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: ColorResources.cardBgColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.offersCardRadius),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResources.borderColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocalStrings.subtotal,
                                      style: boldSmall.copyWith(
                                          color: ColorResources.buttonColor),
                                    ),
                                    Text(
                                      "₹${controller.calculateTotalPrice().round()}",
                                      style: boldMediumLarge.copyWith(
                                        color: ColorResources.buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocalStrings.shippingCharge,
                                      style: boldSmall.copyWith(
                                          color: ColorResources.buttonColor),
                                    ),
                                    Text(
                                      LocalStrings.free,
                                      style: boldSmall.copyWith(
                                        color: ColorResources.offerColor
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocalStrings.shippingInsurance,
                                      style: boldSmall.copyWith(
                                          color: ColorResources.buttonColor),
                                    ),
                                    Text(
                                      LocalStrings.free,
                                      style: boldSmall.copyWith(
                                        color: ColorResources.offerColor
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              const Divider(
                                  color: ColorResources.whiteColor,
                                  height: Dimensions.space10),
                              const SizedBox(height: Dimensions.space10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocalStrings.grandTotal,
                                      style: boldLarge.copyWith(
                                          color: ColorResources.buttonColor),
                                    ),
                                    Obx(
                                      () {
                                        return addCartController
                                                    .isGetCartData.value ==
                                                true
                                            ? Shimmer.fromColors(
                                                baseColor:
                                                    ColorResources.baseColor,
                                                highlightColor: ColorResources
                                                    .highlightColor,
                                                child: Container(
                                                  height: 13,
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .minimumRadius),
                                                    color: ColorResources
                                                        .highlightColor,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                "₹${controller.calculateTotalPrice().round()}",
                                                style: boldMediumLarge.copyWith(
                                                    color: ColorResources
                                                        .buttonColor),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.085),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

//Todo: get cart data time shimmer effect view
  wishlistProductsShimmerEffect(AddToCartController controller) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 3,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          margin: const EdgeInsets.only(bottom: 17),
          decoration: BoxDecoration(
            color: ColorResources.cardBgColor,
            borderRadius: BorderRadius.circular(
              Dimensions.offersCardRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorResources.borderColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.11,
                width: size.width * 0.22,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorResources.lightGreenColour,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.offersCardRadius,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Dimensions.offersCardRadius,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: ColorResources.baseColor,
                    highlightColor: ColorResources.highlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.highlightColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.offersCardRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.space20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.minimumRadius),
                            color: ColorResources.highlightColor,
                          ),
                        )),
                    const SizedBox(height: Dimensions.space5),
                    Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          height: 10,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.minimumRadius),
                            color: ColorResources.highlightColor,
                          ),
                        )),
                    const SizedBox(height: Dimensions.space15),
                    Row(
                      children: [
                        Text(
                          '${LocalStrings.quantity} ',
                          style: boldSmall.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        //Todo : + , - & quantity set and size set only ring & bracelet
                        Row(
                          children: [
                            Text(
                              '+ ',
                              style: semiBoldLarge.copyWith(
                                color: ColorResources.buttonColor,
                              ),
                            ),
                            Shimmer.fromColors(
                                baseColor: ColorResources.baseColor,
                                highlightColor: ColorResources.highlightColor,
                                child: Container(
                                  height: 17,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.minimumRadius),
                                    color: ColorResources.highlightColor,
                                  ),
                                )),
                            Text(
                              ' -',
                              style: semiBoldLarge.copyWith(
                                color: ColorResources.buttonColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: Dimensions.space15),
                        Text(
                          '${LocalStrings.size} ',
                          style: boldSmall.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: ColorResources.baseColor,
                          highlightColor: ColorResources.highlightColor,
                          child: Container(
                            height: 17,
                            width: 9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.minimumRadius),
                              color: ColorResources.highlightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space5),
                    Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          height: 10,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.minimumRadius),
                            color: ColorResources.highlightColor,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.highlightColor),
                child: Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Contacts assistance widget
  contactsWidget(
    GestureTapCallback onTap,
    String image,
    String contactName,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.offersCardRadius),
              gradient: LinearGradient(
                  colors: contactName == LocalStrings.whatsapp
                      ? [
                          ColorResources.lightGreenColour,
                          ColorResources.lightGreenColour.withOpacity(0.3),
                        ]
                      : contactName == LocalStrings.chat
                          ? [
                              ColorResources.offerNineColor.withOpacity(0.3),
                              ColorResources.offerNineColor
                            ]
                          : [
                              ColorResources.offerFirstColor,
                              ColorResources.offerFirstColor.withOpacity(0.3)
                            ],
                  begin: contactName == LocalStrings.whatsapp
                      ? Alignment.topLeft
                      : contactName == LocalStrings.chat
                          ? Alignment.topLeft
                          : Alignment.bottomLeft,
                  end: contactName == LocalStrings.whatsapp
                      ? Alignment.bottomLeft
                      : contactName == LocalStrings.chat
                          ? Alignment.bottomRight
                          : Alignment.topRight),
            ),
            child: Center(
              child: Image.asset(
                image,
              ),
            ),
          ),
          const SizedBox(width: Dimensions.space10),
          Text(
            contactName,
            style: boldLarge.copyWith(
              color: ColorResources.buttonColor,
            ),
          ),
        ],
      ),
    );
  }

  //Todo: Bottom sheet cancel cart items
  bottomSheetWidget(String image, String productName,
      AddToCartController controller, int index, String? productId) {
    final size = MediaQuery.of(context).size;
    final collectionController =
        Get.put<CollectionController>(CollectionController());
    return showModalBottomSheet(
      backgroundColor: ColorResources.cardBgColor,
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
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorResources.cardBgColor,
            borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Dimensions.space20),
              Container(
                height: 5,
                width: 40,
                color: ColorResources.whiteColor,
              ),
              const SizedBox(height: Dimensions.space25),
              Container(
                height: size.height * 0.13,
                width: size.width * 0.27,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.lightGreenColour),
                  borderRadius:
                      BorderRadius.circular(Dimensions.offersCardRadius),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.offersCardRadius),
                  child: CachedCommonImage(
                    width: double.infinity,
                    networkImageUrl: image,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space20),
              Text(
                LocalStrings.moveDesign,
                style:
                    boldMediumLarge.copyWith(color: ColorResources.buttonColor),
              ),
              const SizedBox(height: Dimensions.space10),
              Text(
                LocalStrings.designCart,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: semiBoldSmall.copyWith(),
              ),
              const SizedBox(height: Dimensions.space20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        AppAnalytics().actionTriggerWithProductsLogs(
                            eventName:
                                LocalStrings.logAddCartReMoveProductClick,
                            productName: productName,
                            productImage: image,
                            index: 4);
                        //Todo : Remove product to the cart api method & removeProduct remove locally
                        controller.removeCartApiMethod(itemId: productId);
                        controller.removeProduct(index);
                        Get.back();
                      },
                      child: Container(
                        height: size.height * 0.055,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.offersCardRadius,
                          ),
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                ColorResources.buttonColor,
                                ColorResources.buttonSecondColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        child: Obx(
                          () {
                            return Center(
                              child: controller.isRemoveCart.value == true
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: ColorResources.blackColor,
                                      ),
                                    )
                                  : Text(
                                      LocalStrings.remove,
                                      style: mediumLarge.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space25),
                  Expanded(
                    child: CommonButton(onTap: () {
                      final productController =
                          Get.put<ProductController>(ProductController());

                      //Todo : Move ro wishlist functionality api called & delay some millisecond back
                      collectionController.favoritesProducts(
                          userId: PrefManager.getString('userId'),
                          productId: productId,
                          index: index,
                          isMoveWishlistText: LocalStrings.moveWishlist,
                          size: controller.getAddCartData?.cart
                              ?.quantity?[index].productId?.netWeight14KT
                              ?.toInt(),
                          carat: productController.jewelleryKt(),
                          color: productController.jewelleryColor());
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Get.back();
                      });
                    }, child: Obx(
                      () {
                        return Center(
                          child:
                              collectionController.isMoveWishlist.value == true
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: ColorResources.whiteColor,
                                      ),
                                    )
                                  : Text(
                                      LocalStrings.moveWishlist,
                                      style: mediumLarge.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.whiteColor),
                                    ),
                        );
                      },
                    )),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space20),
            ],
          ),
        );
      },
    );
  }
}
