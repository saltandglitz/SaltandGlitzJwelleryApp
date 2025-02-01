import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:solatn_gleeks/core/utils/images.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';
import 'package:solatn_gleeks/data/controller/add_to_cart/add_to_cart_controller.dart';
import 'package:solatn_gleeks/view/components/common_button.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final addCartController = Get.put<AddToCartController>(AddToCartController());

  @override
  void initState() {
    addCartController.implementAnimationOffersMethod();
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
          title: Text(
              "${LocalStrings.shoppingCart} (${addCartController.productsImage.length})"),
          titleTextStyle: regularLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorResources.conceptTextColor,
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: ColorResources.conceptTextColor,
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
                Text(
                  LocalStrings.grandTotalPrice,
                  style: boldMediumLarge.copyWith(
                      color: ColorResources.conceptTextColor),
                ),
                Text(
                  LocalStrings.viewOrder,
                  style: boldSmall.copyWith(color: ColorResources.offerColor),
                ),
              ],
            ),
            const Spacer(),
            // Common Place order button
            CommonButton(
              onTap: () {},
            ),
          ],
        ),
      ),
      body: GetBuilder<AddToCartController>(
        init: AddToCartController(),
        builder: (controller) {
          return SafeArea(
            top: false,
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    height: size.height * 0.065,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.offersCardRadius),
                      gradient: const LinearGradient(
                        colors: [
                          ColorResources.offerFirstColor,
                          ColorResources.offerNineColor,
                          ColorResources.offerSixColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.2),
                              end: const Offset(0.0, 0.0),
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        key: ValueKey<int>(controller.currentIndex),
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AddToCartController.texts[controller.currentIndex]
                                  ['title']!,
                              style: mediumLarge.copyWith(
                                color: ColorResources.conceptTextColor,
                              ),
                            ),
                          ),
                          Text(
                            AddToCartController.texts[controller.currentIndex]
                                ['subtitle']!,
                            style: dateTextStyle.copyWith(
                              color: ColorResources.conceptTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space15),
                  ListView.builder(
                    itemCount: controller.productsImage.length,
                    physics: const BouncingScrollPhysics(),
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
                              color:
                                  ColorResources.borderColor.withOpacity(0.1),
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
                                  color: ColorResources.offerSixColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius,
                                ),
                                child: CachedCommonImage(
                                  width: double.infinity,
                                  networkImageUrl:
                                      controller.productsImage[index],
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.space20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.productsName[index],
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: mediumSmall.copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        LocalStrings.orderRupeesFirst,
                                        style: boldSmall.copyWith(
                                          color:
                                              ColorResources.conceptTextColor,
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space7),
                                      Text(
                                        LocalStrings.orderRupeesSecond,
                                        style: boldSmall.copyWith(
                                          color: ColorResources.borderColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.space15),
                                  Row(
                                    children: [
                                      Text(
                                        '${LocalStrings.quantity} ${LocalStrings.quantityFirst}',
                                        style: boldSmall.copyWith(
                                          color:
                                              ColorResources.conceptTextColor,
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space20),
                                      Text(
                                        '${LocalStrings.size} ${LocalStrings.quantitySecond}',
                                        style: boldSmall.copyWith(
                                          color:
                                              ColorResources.conceptTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    LocalStrings.deliveryDate,
                                    style: boldSmall.copyWith(
                                      color: ColorResources.deliveryColorColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bottomSheetWidget(
                                  controller.productsImage[index],
                                );
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.conceptTextColor),
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
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocalStrings.offersBenefits,
                      style: semiBoldDefault.copyWith(),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    height: size.height * 0.065,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.offersCardRadius),
                      color: ColorResources.offerThirdTextColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorResources.borderColor.withOpacity(0.3),
                          offset: const Offset(0, 5),
                          blurRadius: 5, // Adjust the blur radius as needed
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              MyImages.discountImage,
                              color: ColorResources.offerColor,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(width: Dimensions.space10),
                            Text(
                              LocalStrings.applyCoupon,
                              style: boldLarge.copyWith(
                                color: ColorResources.conceptTextColor,
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
                                  color: ColorResources.offerThirdTextColor,
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
                                  child: Icon(Icons.arrow_forward_rounded),
                                ),
                              ),
                            ),
                          ],
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
                      borderRadius:
                          BorderRadius.circular(Dimensions.offersCardRadius),
                      boxShadow: [
                        BoxShadow(
                          color: ColorResources.borderColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalStrings.subtotal,
                                style: boldSmall.copyWith(
                                    color: ColorResources.conceptTextColor),
                              ),
                              Text(
                                LocalStrings.orderRupeesFirst,
                                style: boldSmall.copyWith(
                                    color: ColorResources.conceptTextColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalStrings.shippingCharge,
                                style: boldSmall.copyWith(
                                    color: ColorResources.conceptTextColor),
                              ),
                              Text(
                                LocalStrings.free,
                                style: boldSmall.copyWith(
                                    color: ColorResources.deliveryColorColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalStrings.shippingInsurance,
                                style: boldSmall.copyWith(
                                    color: ColorResources.conceptTextColor),
                              ),
                              Text(
                                LocalStrings.free,
                                style: boldSmall.copyWith(
                                    color: ColorResources.deliveryColorColor),
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalStrings.grandTotal,
                                style: boldLarge.copyWith(
                                    color: ColorResources.conceptTextColor),
                              ),
                              Text(
                                LocalStrings.grandTotalPrice,
                                style: boldLarge.copyWith(
                                    color: ColorResources.conceptTextColor),
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
                          ColorResources.offerSixColor,
                          ColorResources.offerSixColor.withOpacity(0.3),
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
              color: ColorResources.conceptTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom sheet cancel cart items
  bottomSheetWidget(String image) {
    final size = MediaQuery.of(context).size;
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
                  border: Border.all(color: ColorResources.offerSixColor),
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
                style: boldMediumLarge.copyWith(
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(height: Dimensions.space10),
              Text(
                LocalStrings.designCart,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: mediumSmall.copyWith(),
              ),
              const SizedBox(height: Dimensions.space20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
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
                                ColorResources.offerColor,
                                ColorResources.buttonGradientColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            LocalStrings.remove,
                            style: mediumLarge.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space25),
                  Expanded(
                    child: CommonButton(
                      onTap: () {
                        Get.back();
                      },
                      buttonName: LocalStrings.moveWishlist,
                    ),
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
