import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/add_to_cart/add_to_cart_controller.dart';
import '../../../data/model/get_add_cart_view_model.dart';
import '../../components/common_button.dart';

/// Bottom sheet for applying coupons
class CouponBottomSheet extends StatefulWidget {
  final List<Coupons>? availableCoupons;
  final AddToCartController controller;

  const CouponBottomSheet({
    super.key,
    this.availableCoupons,
    required this.controller,
  });

  static void show(BuildContext context, AddToCartController controller,
      List<Coupons>? coupons) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CouponBottomSheet(
        controller: controller,
        availableCoupons: coupons,
      ),
    );
  }

  @override
  State<CouponBottomSheet> createState() => _CouponBottomSheetState();
}

class _CouponBottomSheetState extends State<CouponBottomSheet> {
  final TextEditingController _couponController = TextEditingController();
  bool _isApplying = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon(String code) async {
    if (code.isEmpty) return;

    setState(() => _isApplying = true);

    final success = await widget.controller.applyCouponApiMethod(code);

    setState(() => _isApplying = false);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: const EdgeInsets.only(top: 50),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.local_offer,
                      color: ColorResources.buttonColor),
                  const SizedBox(width: 12),
                  Text(
                    'Apply Coupon',
                    style: semiBoldLarge.copyWith(
                      color: ColorResources.buttonColor,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Coupon input
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Enter coupon code',
                        hintStyle: regularDefault.copyWith(
                            color: ColorResources.hintTextColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: ColorResources.borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: ColorResources.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: ColorResources.buttonColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 50,
                    child: CommonButton(
                      onTap: _isApplying
                          ? null
                          : () => _applyCoupon(_couponController.text.trim()),
                      buttonName: _isApplying ? '...' : 'Apply',
                      borderRadius: 12,
                      buttonColor: ColorResources.buttonColor,
                      gradientFirstColor: ColorResources.buttonColor,
                      gradientSecondColor: ColorResources.buttonColorDark,
                      textStyle: semiBoldDefault.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // Available coupons section
            if (widget.availableCoupons != null &&
                widget.availableCoupons!.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Available Coupons',
                    style: semiBoldDefault.copyWith(
                        color: ColorResources.buttonColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.35,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.availableCoupons!.length,
                  itemBuilder: (context, index) {
                    final coupon = widget.availableCoupons![index];
                    return _buildCouponCard(coupon);
                  },
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(Coupons coupon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.lightGreenColour, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Left side - Coupon code badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: ColorResources.lightGreenColour,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  coupon.couponOffer ?? '',
                  style: boldLarge.copyWith(
                    color: ColorResources.buttonColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'OFF',
                  style: boldSmall.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
              ],
            ),
          ),
          // Right side - Coupon details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ColorResources.buttonColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: ColorResources.buttonColor.withOpacity(0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text(
                          coupon.couponCode ?? '',
                          style: boldSmall.copyWith(
                            color: ColorResources.buttonColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: coupon.couponCode ?? ''));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code copied!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.copy,
                          size: 16,
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    coupon.couponContent ?? '',
                    style: regularSmall.copyWith(
                      color: ColorResources.borderColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Redeem button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _isApplying
                  ? null
                  : () => _applyCoupon(coupon.couponCode ?? ''),
              style: TextButton.styleFrom(
                backgroundColor: ColorResources.buttonColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Redeem',
                style: semiBoldSmall.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget to display applied coupon with remove option
class AppliedCouponCard extends StatelessWidget {
  final String couponCode;
  final double discount;
  final VoidCallback onRemove;
  final bool isLoading;

  const AppliedCouponCard({
    super.key,
    required this.couponCode,
    required this.discount,
    required this.onRemove,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColorResources.offerColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.offersCardRadius),
        border: Border.all(
          color: ColorResources.offerColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorResources.offerColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle,
              color: ColorResources.offerColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$couponCode applied',
                  style: semiBoldDefault.copyWith(
                    color: ColorResources.offerColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '-₹${discount.round()} discount',
                  style: regularSmall.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, size: 20),
              color: ColorResources.notValidateColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
