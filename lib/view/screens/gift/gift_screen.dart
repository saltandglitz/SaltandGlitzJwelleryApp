import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/gift/gift_controller.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/common_button.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key});

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainController = Get.put<MainController>(MainController());
    final giftController = Get.put<GiftController>(GiftController());
    String? selectedRecipient;

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title:  Text(LocalStrings.appName),
          titleTextStyle: regularLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorResources.conceptTextColor,
          ),
          leading: IconButton(
            onPressed: () {
              mainController.checkToAssignNetworkConnections();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: ColorResources.conceptTextColor,
          ),
          backgroundColor: ColorResources.whiteColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: Dimensions.space10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocalStrings.chooseAGiftWrap,
                    style: boldMediumLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff589496),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  Text(
                    "(${LocalStrings.free})",
                    style: boldMediumLarge.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: size.width * 0.28,
                    decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffd3d3d3),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  MyImages.ringOneImage,
                                ), // Change the image path
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff6d9ebc), // Background for text
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              LocalStrings.warmHugs,
                              style: boldDefault.copyWith(
                                color: ColorResources.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  Container(
                    height: size.height * 0.25,
                    width: size.width * 0.28,
                    decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffd3d3d3),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  MyImages.ringOneImage,
                                ), // Change the image path
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xffb4d9ed), // Background for text
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              LocalStrings.purpleAun,
                              style: semiBoldDefault.copyWith(
                                color: ColorResources.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  Container(
                    height: size.height * 0.25,
                    width: size.width * 0.28,
                    decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffd3d3d3),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  MyImages.ringOneImage,
                                ), // Change the image path
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xffb4d9ed), // Background for text
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              LocalStrings.fairyTales,
                              style: semiBoldDefault.copyWith(
                                color: ColorResources.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocalStrings.addAGiftMessage,
                    style: boldMediumLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff589496),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  Text(
                    "(${LocalStrings.optional})",
                    style: boldMediumLarge.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space15),
              CommonTextField(
                textFieldHeight: size.height * 0.2,
                maxLines: 5,
                fillColor: const Color(0xfff0f0f0),
                hintText: LocalStrings.youCanWriteAPersonalNote,
                hintTexStyle: semiBoldDefault.copyWith(
                  color: Colors.grey,
                ),
                maxLength: 250,
              ),
              const SizedBox(height: Dimensions.space40),
              Center(
                child: Text(
                  LocalStrings.whoIsThisGiftFor,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              Container(
                height: size.height * 0.05,
                color: ColorResources.whiteColor,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: giftController.recipients.map((recipient) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        backgroundColor: ColorResources.whiteColor,
                        label: Text(
                          recipient,
                          style: semiBoldSmall.copyWith(
                            color: ColorResources.conceptTextColor,
                          ),
                        ),
                        selected: selectedRecipient == recipient,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedRecipient = selected ? recipient : null;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              CommonTextField(
                fillColor: ColorResources.whiteColor,
                hintText: LocalStrings.recipientsMobile,
              ),
              const SizedBox(height: Dimensions.space50),
              CommonButton(
                // gradientFirstColor: const Color(0xff6d9ebc),
                // gradientSecondColor: const Color(0xff6d9ebc),
                gradientFirstColor: ColorResources.conceptTextColor,
                gradientSecondColor: ColorResources.conceptTextColor,
                width: double.infinity,
                onTap: () {
                  Get.toNamed(RouteHelper.paymentScreen);
                },
                buttonName: LocalStrings.processToPayment,
                textStyle: mediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
              // const SizedBox(height: Dimensions.space70),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     LocalStrings.orderSummary,
              //     style: mediumExtraLarge.copyWith(
              //       fontWeight: FontWeight.w900,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: Dimensions.space30),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Align(
              //       alignment: Alignment.topLeft,
              //       child: Container(
              //         width: size.width * 0.32,
              //         height: size.height * 0.15,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border:
              //               Border.all(color: ColorResources.conceptTextColor),
              //           color: ColorResources.whiteColor,
              //           image: const DecorationImage(
              //             image: AssetImage(MyImages.ringOneImage),
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: Dimensions.space20),
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           LocalStrings.earring,
              //           style: mediumDefault.copyWith(
              //             fontWeight: FontWeight.w900,
              //           ),
              //         ),
              //         Text(
              //           LocalStrings.sku,
              //           style: mediumDefault.copyWith(),
              //         ),
              //         Text(
              //           "${LocalStrings.quantity}: 1",
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text(
              //           LocalStrings.price,
              //           style: mediumLarge.copyWith(),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(height: Dimensions.space30),
              // const Divider(),
              // const SizedBox(height: Dimensions.space20),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           LocalStrings.subTotal2,
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text(
              //           "₹ 5,35,448",
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           LocalStrings.couponDiscount,
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text(
              //           "-₹0",
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.green,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           LocalStrings.shippingCharges,
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Text(
              //           "FREE",
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.bold,
              //             color: ColorResources.offerColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(height: Dimensions.space20),
              // const Divider(),
              // const SizedBox(height: Dimensions.space2),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       LocalStrings.totalCost,
              //       style: mediumLarge.copyWith(
              //         fontWeight: FontWeight.w900,
              //       ),
              //     ),
              //     Text(
              //       "₹ 5,35,448",
              //       style: mediumLarge.copyWith(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: Dimensions.space20),
              // Center(
              //   child: Text(
              //     LocalStrings.needHelp2,
              //     style: mediumLarge.copyWith(
              //       fontWeight: FontWeight.bold,
              //       color: ColorResources.offerColor,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: Dimensions.space15),
              // Center(
              //   child: Text(
              //     LocalStrings.weAreAvailable,
              //     textAlign: TextAlign.center,
              //     style: mediumDefault.copyWith(),
              //   ),
              // ),
              // const SizedBox(height: Dimensions.space35),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: const BoxDecoration(
              //         color: ColorResources.conceptTextColor,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Center(
              //         child: Image.asset(
              //           MyImages.whatsappImage,
              //           height: size.height * 0.025,
              //           color: ColorResources.whiteColor,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: const BoxDecoration(
              //         color: ColorResources.conceptTextColor,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Center(
              //         child: Image.asset(
              //           MyImages.emailImage,
              //           height: size.height * 0.025,
              //           color: ColorResources.whiteColor,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 40,
              //       width: 40,
              //       decoration: const BoxDecoration(
              //         color: ColorResources.conceptTextColor,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Center(
              //         child: Image.asset(
              //           MyImages.phoneCallImage,
              //           height: size.height * 0.025,
              //           color: ColorResources.whiteColor,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: Dimensions.space25),
              // const Divider(),
              // const SizedBox(height: Dimensions.space60),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           LocalStrings.contactUs2,
              //           style: mediumLarge.copyWith(
              //             fontWeight: FontWeight.w900,
              //           ),
              //         ),
              //         Text(
              //           LocalStrings.contactNumber,
              //           style: mediumLarge.copyWith(),
              //         ),
              //       ],
              //     ),
              //     Text(
              //       LocalStrings.contactUsAt,
              //       style: mediumLarge.copyWith(),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
