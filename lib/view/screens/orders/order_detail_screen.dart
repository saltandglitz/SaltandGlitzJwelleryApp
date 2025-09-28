import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/core/utils/style.dart';
import 'package:saltandGlitz/data/model/order/order_model.dart';
import 'package:saltandGlitz/data/controller/orders/orders_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Order order = Get.arguments as Order;
    final OrdersController ordersController = Get.find<OrdersController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorResources.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorResources.buttonColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Order Details',
          style: semiBoldLarge.copyWith(
            color: ColorResources.buttonColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id.substring(order.id.length - 8)}',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ordersController
                              .getOrderStatusColor(order.status)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: ordersController
                                .getOrderStatusColor(order.status),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          ordersController.getOrderStatusText(order.status),
                          style: semiBoldSmall.copyWith(
                            color: ordersController
                                .getOrderStatusColor(order.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: ColorResources.borderColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ordered on ${ordersController.formatOrderDateTime(order.orderDate)}',
                        style: regularDefault.copyWith(
                          color: ColorResources.borderColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorResources.deliveryColorColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: semiBoldDefault.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        Text(
                          '₹${order.totalPrice.toStringAsFixed(2)}',
                          style: semiBoldLarge.copyWith(
                            color: ColorResources.buttonColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Items
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: ColorResources.buttonColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Order Items (${order.cartId.quantity.length})',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...order.cartId.quantity.map((item) => Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: ColorResources.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: ColorResources.deliveryColorColor
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${item.quantity}',
                                      style: semiBoldDefault.copyWith(
                                        color: ColorResources.buttonColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productId.title,
                                        style: semiBoldDefault.copyWith(
                                          color: ColorResources.buttonColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${item.caratBy} • ${item.colorBy}',
                                        style: regularSmall.copyWith(
                                          color: ColorResources.borderColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Size: ${item.size}',
                                        style: regularSmall.copyWith(
                                          color: ColorResources.borderColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${item.totalPrice.toStringAsFixed(2)}',
                                  style: semiBoldDefault.copyWith(
                                    color: ColorResources.buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Customer Information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: ColorResources.buttonColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Customer Information',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInfoRow(
                    'Name',
                    order.cartId.userId.fullName,
                    Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    'Email',
                    order.cartId.userId.email,
                    Icons.email_outlined,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    'Phone',
                    order.cartId.userId.mobileNumber,
                    Icons.phone_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Shipping Address
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorResources.buttonColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Shipping Address',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorResources.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorResources.borderColor.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      order.shippingAddress.fullAddress,
                      style: regularDefault.copyWith(
                        color: ColorResources.buttonColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Billing Address
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_outlined,
                        color: ColorResources.buttonColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Billing Address',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorResources.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorResources.borderColor.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      order.billingAddress.fullAddress,
                      style: regularDefault.copyWith(
                        color: ColorResources.buttonColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        color: ColorResources.buttonColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Order Summary',
                        style: semiBoldLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildSummaryRow('Cart Total',
                      '₹${order.cartId.cartTotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  if (order.cartId.saltCashUsed > 0) ...[
                    _buildSummaryRow('Salt Cash Used',
                        '-₹${order.cartId.saltCashUsed.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                  ],
                  if (order.cartId.appliedCoupon != null) ...[
                    _buildSummaryRow(
                        'Coupon Applied', order.cartId.appliedCoupon!),
                    const SizedBox(height: 8),
                  ],
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'Total Amount',
                    '₹${order.totalPrice.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: ColorResources.borderColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: regularSmall.copyWith(
                  color: ColorResources.borderColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not provided',
                style: regularDefault.copyWith(
                  color: ColorResources.buttonColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? semiBoldDefault.copyWith(color: ColorResources.buttonColor)
              : regularDefault.copyWith(color: ColorResources.borderColor),
        ),
        Text(
          value,
          style: isTotal
              ? semiBoldDefault.copyWith(color: ColorResources.buttonColor)
              : regularDefault.copyWith(color: ColorResources.buttonColor),
        ),
      ],
    );
  }
}
