import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/core/route/route.dart';
import 'package:saltandglitz/core/utils/color_resources.dart';

import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/core/utils/style.dart';
import 'package:saltandglitz/data/controller/orders/orders_controller.dart';
import 'package:saltandglitz/data/model/order/order_model.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';
import 'package:saltandglitz/main_controller.dart';
import 'package:saltandglitz/view/components/app_circular_loader.dart';
import 'package:saltandglitz/view/components/network_connectivity_view.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersController ordersController = Get.put(OrdersController());
  final MainController mainController = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    mainController.checkToAssignNetworkConnections();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
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
              'My Orders',
              style: semiBoldLarge.copyWith(
                color: ColorResources.buttonColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: mainController.isNetworkConnection?.value == false
                ? NetworkConnectivityView(
                    onTap: () async {
                      RxBool? isEnableNetwork = await mainController
                          .checkToAssignNetworkConnections();
                      if (isEnableNetwork!.value == true) {
                        ordersController.enableNetworkHideLoader();
                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            Get.put<OrdersController>(OrdersController());
                            ordersController.disableNetworkLoaderByDefault();
                          },
                        );
                        ordersController.update();
                      }
                    },
                    isLoading: ordersController.isEnableNetwork,
                  )
                : PrefManager.getString('isLogin') != 'yes'
                    ? _buildLoginPrompt(context, size)
                    : _buildOrdersList(context, size),
          ),
        );
      },
    );
  }

  Widget _buildLoginPrompt(BuildContext context, Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: ColorResources.borderColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Please login to view your orders',
              style: semiBoldLarge.copyWith(
                color: ColorResources.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Sign in to access your order history and track your purchases',
              style: regularDefault.copyWith(
                color: ColorResources.borderColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width * 0.6,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(RouteHelper.loginScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  LocalStrings.login,
                  style: semiBoldDefault.copyWith(
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, Size size) {
    return Obx(() {
      if (ordersController.isLoading.value) {
        return Center(child: AppCircularLoader());
      }

      if (ordersController.hasError.value) {
        return _buildErrorView(context, size);
      }

      if (ordersController.orders.isEmpty) {
        return _buildEmptyView(context, size);
      }

      return RefreshIndicator(
        onRefresh: ordersController.refreshOrders,
        child: Column(
          children: [
            _buildOrdersHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: ordersController.orders.length,
                itemBuilder: (context, index) {
                  final order = ordersController.orders[index];
                  return _buildOrderCard(order, context, size);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildOrdersHeader() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(15),
        color: ColorResources.deliveryColorColor.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Orders',
                  style: mediumDefault.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
                Text(
                  '${ordersController.totalOrders.value}',
                  style: semiBoldLarge.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total Value',
                  style: mediumDefault.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
                Text(
                  '₹${ordersController.totalOrderValue.toStringAsFixed(2)}',
                  style: semiBoldLarge.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildOrderCard(Order order, BuildContext context, Size size) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () =>
            Get.toNamed(RouteHelper.orderDetailScreen, arguments: order),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id.substring(order.id.length - 8)}',
                    style: semiBoldDefault.copyWith(
                      color: ColorResources.buttonColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ordersController
                          .getOrderStatusColor(order.status)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            ordersController.getOrderStatusColor(order.status),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      ordersController.getOrderStatusText(order.status),
                      style: mediumSmall.copyWith(
                        color:
                            ordersController.getOrderStatusColor(order.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Order date
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: ColorResources.borderColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Ordered on ${ordersController.formatOrderDate(order.orderDate)}',
                    style: regularSmall.copyWith(
                      color: ColorResources.borderColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Products
              if (order.cartId.quantity.isNotEmpty) ...[
                Text(
                  'Items:',
                  style: semiBoldSmall.copyWith(
                    color: ColorResources.buttonColor,
                  ),
                ),
                const SizedBox(height: 5),
                ...order.cartId.quantity.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ColorResources.deliveryColorColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${item.quantity}',
                                style: semiBoldSmall.copyWith(
                                  color: ColorResources.buttonColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productId.title,
                                  style: regularDefault.copyWith(
                                    color: ColorResources.buttonColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${item.caratBy} • ${item.colorBy} • Size ${item.size}',
                                  style: regularSmall.copyWith(
                                    color: ColorResources.borderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${item.totalPrice.toStringAsFixed(2)}',
                            style: semiBoldSmall.copyWith(
                              color: ColorResources.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              const SizedBox(height: 15),

              // Order total and shipping address
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorResources.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: semiBoldDefault.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        Text(
                          '₹${order.totalPrice.toStringAsFixed(2)}',
                          style: semiBoldLarge.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: ColorResources.borderColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Shipping to: ${order.shippingAddress.fullAddress}',
                            style: regularSmall.copyWith(
                              color: ColorResources.borderColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: ColorResources.borderColor,
            ),
            const SizedBox(height: 20),
            Text(
              'No Orders Yet',
              style: semiBoldLarge.copyWith(
                color: ColorResources.buttonColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Start shopping to see your orders here',
              style: regularDefault.copyWith(
                color: ColorResources.borderColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width * 0.6,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(RouteHelper.dashboardScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Start Shopping',
                  style: semiBoldDefault.copyWith(
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.withOpacity(0.6),
            ),
            const SizedBox(height: 20),
            Text(
              'Unable to Load Orders',
              style: semiBoldLarge.copyWith(
                color: ColorResources.buttonColor,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(
                  ordersController.errorMessage.value,
                  style: regularDefault.copyWith(
                    color: ColorResources.borderColor,
                  ),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width * 0.6,
              child: ElevatedButton(
                onPressed: () => ordersController.refreshOrders(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: semiBoldDefault.copyWith(
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
