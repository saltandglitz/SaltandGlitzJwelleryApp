import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/referrer/referrer_controller.dart';
import '../../../local_storage/pref_manager.dart';
import '../../components/common_button.dart';
import '../../components/common_message_show.dart';

/// Special User Screen - Shows referrer application, pending status, or dashboard
class SpecialUserScreen extends StatefulWidget {
  const SpecialUserScreen({super.key});

  @override
  State<SpecialUserScreen> createState() => _SpecialUserScreenState();
}

class _SpecialUserScreenState extends State<SpecialUserScreen> {
  final referrerController = Get.put<ReferrerController>(ReferrerController());

  @override
  void initState() {
    super.initState();
    referrerController.fetchReferrerStatus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorResources.buttonColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Special User Program',
          style: semiBoldLarge.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ReferrerController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.buttonColor,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: _buildContent(controller, size),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(ReferrerController controller, Size size) {
    switch (controller.referrerStatus.value) {
      case 'approved':
        return _buildApprovedView(controller, size);
      case 'pending':
        return _buildPendingView(controller, size);
      case 'rejected':
        return _buildRejectedView(controller, size);
      default:
        return _buildApplyView(controller, size);
    }
  }

  /// View for users who haven't applied yet
  Widget _buildApplyView(ReferrerController controller, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Icon
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorResources.buttonColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.star_rounded,
            size: 64,
            color: ColorResources.buttonColor,
          ),
        ),
        const SizedBox(height: 30),
        // Title
        Text(
          'Become a Special User',
          style: semiBoldExtraLarge.copyWith(
            color: ColorResources.buttonColor,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          'Join our exclusive referral program! As a Special User, you\'ll receive a unique 20% discount coupon code to share with friends and family.',
          style: regularDefault.copyWith(
            color: ColorResources.borderColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        // Benefits card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Benefits',
                style: semiBoldLarge.copyWith(color: ColorResources.buttonColor),
              ),
              const SizedBox(height: 16),
              _buildBenefitItem(Icons.discount, 'Exclusive 20% discount code'),
              _buildBenefitItem(Icons.share, 'Share with friends & family'),
              _buildBenefitItem(Icons.analytics, 'Track your referral stats'),
              _buildBenefitItem(Icons.card_giftcard, 'Earn rewards on referrals'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Reason input (optional)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us why you want to join (optional)',
                style: mediumDefault.copyWith(color: ColorResources.buttonColor),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.reasonController,
                maxLines: 3,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'E.g., I have a large social media following...',
                  hintStyle: regularDefault.copyWith(color: ColorResources.borderColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: ColorResources.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: ColorResources.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: ColorResources.buttonColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Apply button
        Obx(() => CommonButton(
              onTap: controller.isSubmitting.value
                  ? null
                  : () async {
                      final success = await controller.submitReferrerRequest();
                      if (success && mounted) {
                        showToast(
                          context: context,
                          message: 'Application submitted successfully!',
                        );
                      } else if (controller.errorMessage.value.isNotEmpty && mounted) {
                        showToast(
                          context: context,
                          message: controller.errorMessage.value,
                        );
                      }
                    },
              borderRadius: 12,
              height: 52,
              width: double.infinity,
              buttonColor: ColorResources.buttonColor,
              gradientFirstColor: ColorResources.buttonColor,
              gradientSecondColor: ColorResources.buttonColorDark,
              child: controller.isSubmitting.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Apply Now',
                      style: semiBoldLarge.copyWith(color: Colors.white),
                    ),
            )),
        const SizedBox(height: 40),
      ],
    );
  }

  /// View for users with pending application
  Widget _buildPendingView(ReferrerController controller, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        // Pending icon
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.hourglass_top_rounded,
            size: 64,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 30),
        // Title
        Text(
          'Application Pending',
          style: semiBoldExtraLarge.copyWith(
            color: ColorResources.buttonColor,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          'Your application to become a Special User is under review. We\'ll notify you once it\'s approved.',
          style: regularDefault.copyWith(
            color: ColorResources.borderColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Info card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.orange),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'This usually takes 1-2 business days. Please check back later.',
                  style: regularDefault.copyWith(color: Colors.orange.shade800),
                ),
              ),
            ],
          ),
        ),
        if (controller.latestRequest.value?.reason != null &&
            controller.latestRequest.value!.reason!.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Application',
                  style: semiBoldLarge.copyWith(color: ColorResources.buttonColor),
                ),
                const SizedBox(height: 12),
                Text(
                  controller.latestRequest.value!.reason!,
                  style: regularDefault.copyWith(color: ColorResources.borderColor),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }

  /// View for approved referrers - Dashboard
  Widget _buildApprovedView(ReferrerController controller, Size size) {
    final firstName = PrefManager.getString('firstName') ?? 'User';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ColorResources.buttonColor, ColorResources.buttonColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.star, color: Colors.amber, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Special User',
                    style: semiBoldLarge.copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome, $firstName!',
                style: semiBoldExtraLarge.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your exclusive code and earn rewards!',
                style: regularDefault.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Promo code card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Your Promo Code',
                style: mediumDefault.copyWith(color: ColorResources.borderColor),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: ColorResources.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorResources.buttonColor.withOpacity(0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  controller.couponCode.value,
                  style: semiBoldExtraLarge.copyWith(
                    color: ColorResources.buttonColor,
                    fontSize: 28,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '20% OFF for your friends!',
                style: mediumDefault.copyWith(color: Colors.green),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.copy,
                      label: 'Copy',
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: controller.couponCode.value),
                        );
                        showToast(
                          context: context,
                          message: 'Code copied to clipboard!',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      isPrimary: true,
                      onTap: () {
                        Share.share(
                          'Use my exclusive code ${controller.couponCode.value} to get 20% OFF on Salt & Glitz jewelry! 💎✨\n\nShop now: https://saltandglitz.com',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Stats section
        Text(
          'Your Stats',
          style: semiBoldLarge.copyWith(color: ColorResources.buttonColor),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.discount,
                value: '${controller.stats.value?.totalUses ?? 0}',
                label: 'Code Uses',
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                icon: Icons.shopping_bag,
                value: '${controller.stats.value?.totalOrders ?? 0}',
                label: 'Orders',
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Recent orders (if any)
        if (controller.stats.value?.orders != null &&
            controller.stats.value!.orders!.isNotEmpty) ...[
          Text(
            'Recent Referral Orders',
            style: semiBoldLarge.copyWith(color: ColorResources.buttonColor),
          ),
          const SizedBox(height: 16),
          ...controller.stats.value!.orders!.take(5).map(
                (order) => _buildOrderItem(order),
              ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }

  /// View for rejected applications
  Widget _buildRejectedView(ReferrerController controller, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        // Rejected icon
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.cancel_outlined,
            size: 64,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 30),
        // Title
        Text(
          'Application Not Approved',
          style: semiBoldExtraLarge.copyWith(
            color: ColorResources.buttonColor,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          'We\'re sorry, but your application wasn\'t approved at this time. You can try again later.',
          style: regularDefault.copyWith(
            color: ColorResources.borderColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        if (controller.latestRequest.value?.adminNotes != null &&
            controller.latestRequest.value!.adminNotes!.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feedback',
                  style: semiBoldDefault.copyWith(color: Colors.red.shade800),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.latestRequest.value!.adminNotes!,
                  style: regularDefault.copyWith(color: Colors.red.shade700),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }

  /// Helper widget for benefit items
  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: regularDefault.copyWith(color: ColorResources.buttonColor),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for action buttons
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? ColorResources.buttonColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isPrimary ? Colors.white : ColorResources.buttonColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: semiBoldDefault.copyWith(
                color: isPrimary ? Colors.white : ColorResources.buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget for stat cards
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: semiBoldExtraLarge.copyWith(
              color: ColorResources.buttonColor,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: regularSmall.copyWith(color: ColorResources.borderColor),
          ),
        ],
      ),
    );
  }

  /// Helper widget for order items
  Widget _buildOrderItem(dynamic order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id?.substring(order.id!.length - 6) ?? 'N/A'}',
                  style: semiBoldDefault.copyWith(color: ColorResources.buttonColor),
                ),
                const SizedBox(height: 4),
                Text(
                  order.status?.toUpperCase() ?? 'Completed',
                  style: regularSmall.copyWith(color: ColorResources.borderColor),
                ),
              ],
            ),
          ),
          if (order.cartTotal != null)
            Text(
              '₹${order.cartTotal!.toStringAsFixed(0)}',
              style: semiBoldDefault.copyWith(color: Colors.green),
            ),
        ],
      ),
    );
  }
}
