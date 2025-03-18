import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/main_controller.dart';
import 'package:saltandGlitz/view/components/common_button.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../components/app_bar_background.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

bool isSameAsShipping = true;

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    void toggleSelection() {
      setState(() {
        isSameAsShipping = !isSameAsShipping;
      });
    }

    String? selectedAddressType;
    final size = MediaQuery.of(context).size;
    final mainController = Get.put<MainController>(MainController());

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: const Text(LocalStrings.appName),
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
          actions: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorResources.whatsappColor,
                  radius: 20,
                  child: Image.asset(
                    MyImages.whatsappImage,
                    height: size.height * 0.025,
                    color: ColorResources.whiteColor,
                  ),
                ),
                const SizedBox(width: Dimensions.space12),
              ],
            ),
          ],
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
              Center(
                child: Text(
                  LocalStrings.deliveryDetails,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              Container(
                width: double.infinity,
                height: size.height * 0.24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffe2ecee),
                  border: Border.all(
                    color: const Color(0xffc3dbda),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          LocalStrings.homeDelivery,
                          style: mediumDefault.copyWith(
                            fontWeight: FontWeight.w900,
                            color: ColorResources.conceptTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space30),
                    Text(
                      LocalStrings.earliestDelivery,
                      style: mediumSmall.copyWith(
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CommonButton(
                      buttonName: LocalStrings.changeYourDeliveryDate,
                      textStyle: mediumSmall.copyWith(
                        color: ColorResources.blackColor,
                      ),
                      height: size.height * 0.046,
                      width: size.width * 0.6,
                      gradientFirstColor: ColorResources.whiteColor,
                      gradientSecondColor: ColorResources.whiteColor,
                    )
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              Container(
                width: double.infinity,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff6f4f9),
                  border: Border.all(
                    color: const Color(0xffe8e4ef),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalStrings.inStorePickUp,
                      style: mediumDefault.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                    const SizedBox(height: Dimensions.space20),
                    Text(
                      LocalStrings.buyNowPickUp,
                      style: mediumSmall.copyWith(
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space40),
              Center(
                child: Text(
                  LocalStrings.shippingAddress,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              GestureDetector(
                onTap: () {
                  mainController.checkToAssignNetworkConnections();
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: ColorResources.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                LocalStrings.addANewAddress,
                                style: boldMediumLarge,
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.firstName,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.lastName,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              CommonTextField(
                                hintText: LocalStrings.streetHouseNumber,
                                hintTexStyle: mediumDefault,
                                fillColor: ColorResources.whiteColor,
                              ),
                              const SizedBox(height: Dimensions.space10),
                              CommonTextField(
                                hintText: LocalStrings.additionalInformation,
                                hintTexStyle: mediumDefault,
                                fillColor: ColorResources.whiteColor,
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.pinCode,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.city,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.state,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  Expanded(
                                    child: CommonTextField(
                                      hintText: LocalStrings.country,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              CommonTextField(
                                hintText: LocalStrings.mobileNumber,
                                hintTexStyle: mediumDefault,
                                fillColor: ColorResources.whiteColor,
                              ),
                              const SizedBox(height: Dimensions.space10),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  fillColor: ColorResources.whiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorResources.borderColor,
                                      width: 1,
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                hint: const Text(
                                  LocalStrings.selectAddressType,
                                  style: TextStyle(
                                    color: ColorResources.borderColor,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: ColorResources.blackColor,
                                ),
                                value: selectedAddressType,
                                items: ['Home', 'Work', 'Other']
                                    .map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        color: ColorResources.blackColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  selectedAddressType = value;
                                },
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xfff0f4f7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Text(
                        LocalStrings.addANewAddress,
                        style: mediumDefault.copyWith(
                          color: ColorResources.conceptTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Transform.translate(
                        offset: const Offset(270, -3),
                        child: Container(
                          height: size.height * 0.1,
                          width: size.width * 0.099,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResources.borderColor.withOpacity(0.1),
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
              const SizedBox(height: Dimensions.space30),
              Center(
                child: Text(
                  LocalStrings.billingAddress,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              // Container(
              //   width: double.infinity,
              //   height: size.height * 0.10,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: const Color(0xfff6f4f9),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade300,
              //         spreadRadius: 3,
              //         blurRadius: 6,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   alignment: Alignment.centerLeft,
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         LocalStrings.sameAsShippingAddress,
              //         style: mediumDefault.copyWith(
              //           color: ColorResources.conceptTextColor,
              //           fontWeight: FontWeight.w900,
              //         ),
              //       ),
              //       Radio<bool>(
              //         value: true,
              //         groupValue: selectedValue
              //             ? true
              //             : null, // Deselect on second click
              //         onChanged: (value) {
              //           toggleSelection(); // Toggle on click
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: Dimensions.space15),
              // Container(
              //   width: double.infinity,
              //   height: size.height * 0.10,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: const Color(0xfff6f4f9),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade300,
              //         spreadRadius: 3,
              //         blurRadius: 6,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   alignment: Alignment.centerLeft,
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         LocalStrings.useADifferentBillingAddress,
              //         style: mediumDefault.copyWith(
              //           color: ColorResources.conceptTextColor,
              //           fontWeight: FontWeight.w900,
              //         ),
              //       ),
              //       Radio<bool>(
              //         value: true,
              //         groupValue: selectedValue
              //             ? true
              //             : null, // Deselect on second click
              //         onChanged: (value) {
              //           toggleSelection();
              //           // Toggle on click
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRadioTile(
                    size * 0.9,
                    LocalStrings.sameAsShippingAddress,
                    isSameAsShipping,
                    () => toggleSelection(),
                  ),
                  const SizedBox(height: Dimensions.space15),
                  _buildRadioTile(
                    size * 0.9,
                    LocalStrings.useADifferentBillingAddress,
                    !isSameAsShipping,
                    () => toggleSelection(),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space15),
              isSameAsShipping
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              LocalStrings.addANewAddress,
                              style: boldMediumLarge,
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.firstName,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.lastName,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.space10),
                            CommonTextField(
                              hintText: LocalStrings.streetHouseNumber,
                              hintTexStyle: mediumDefault,
                              fillColor: ColorResources.whiteColor,
                            ),
                            const SizedBox(height: Dimensions.space10),
                            CommonTextField(
                              hintText: LocalStrings.additionalInformation,
                              hintTexStyle: mediumDefault,
                              fillColor: ColorResources.whiteColor,
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.pinCode,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.city,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.state,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Expanded(
                                  child: CommonTextField(
                                    hintText: LocalStrings.country,
                                    hintTexStyle: mediumDefault,
                                    fillColor: ColorResources.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.space10),
                            CommonTextField(
                              hintText: LocalStrings.mobileNumber,
                              hintTexStyle: mediumDefault,
                              fillColor: ColorResources.whiteColor,
                            ),
                            const SizedBox(height: Dimensions.space10),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                fillColor: ColorResources.whiteColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: ColorResources.borderColor,
                                    width: 1,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              hint: const Text(
                                LocalStrings.selectAddressType,
                                style: TextStyle(
                                  color: ColorResources.borderColor,
                                ),
                              ),
                              style: const TextStyle(
                                color: ColorResources.blackColor,
                              ),
                              value: selectedAddressType,
                              items:
                                  ['Home', 'Work', 'Other'].map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      color: ColorResources.blackColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectedAddressType = value;
                              },
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: Dimensions.space20),
              CommonButton(
                gradientFirstColor: ColorResources.conceptTextColor,
                gradientSecondColor: ColorResources.conceptTextColor,
                width: double.infinity,
                buttonName: LocalStrings.continuePlaceOrder,
                onTap: () {
                  Get.toNamed(RouteHelper.giftScreen);
                },
                textStyle: boldMediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
              const SizedBox(height: Dimensions.space70),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  LocalStrings.orderSummary,
                  style: mediumExtraLarge.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size.width * 0.32,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: ColorResources.conceptTextColor),
                        color: ColorResources.whiteColor,
                        image: const DecorationImage(
                          image: AssetImage(MyImages.ringOneImage),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalStrings.earring,
                        style: mediumDefault.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        LocalStrings.sku,
                        style: mediumDefault.copyWith(),
                      ),
                      Text(
                        "${LocalStrings.quantity}: 1",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        LocalStrings.price,
                        style: mediumLarge.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space30),
              const Divider(),
              const SizedBox(height: Dimensions.space20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.subTotal2,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ 5,35,448",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.couponDiscount,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "-₹0",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.shippingCharges,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "FREE",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorResources.offerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space20),
              const Divider(),
              const SizedBox(height: Dimensions.space2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalStrings.totalCost,
                    style: mediumLarge.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "₹ 5,35,448",
                    style: mediumLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space20),
              Center(
                child: Text(
                  LocalStrings.needHelp2,
                  style: mediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorResources.offerColor,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              Center(
                child: Text(
                  LocalStrings.weAreAvailable,
                  textAlign: TextAlign.center,
                  style: mediumDefault.copyWith(),
                ),
              ),
              const SizedBox(height: Dimensions.space35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.whatsappImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.emailImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.phoneCallImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space25),
              const Divider(),
              const SizedBox(height: Dimensions.space60),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocalStrings.contactUs2,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        LocalStrings.contactNumber,
                        style: mediumLarge.copyWith(),
                      ),
                    ],
                  ),
                  Text(
                    LocalStrings.contactUsAt,
                    style: mediumLarge.copyWith(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRadioTile(
  Size size,
  String title,
  bool isSelected,
  VoidCallback onTap,
) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: const Color(0xfff6f4f9),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text(
        title,
        style: mediumLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorResources.conceptTextColor,
        ),
      ),
      trailing: Radio<bool>(
        value: true,
        groupValue: isSelected ? true : null,
        activeColor: ColorResources.conceptTextColor,
        onChanged: (value) => onTap(),
      ),
      onTap: onTap,
    ),
  );
}
