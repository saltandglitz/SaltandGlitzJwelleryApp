import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandglitz/api_repository/dio_client.dart';
import 'package:saltandglitz/data/model/order/order_model.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';

class OrdersController extends GetxController {
  // Loading states
  RxBool isLoading = false.obs;
  RxBool isEnableNetwork = false.obs;

  // Data
  RxList<Order> orders = <Order>[].obs;
  RxInt totalOrders = 0.obs;
  RxString userId = ''.obs;
  RxString cartId = ''.obs;
  RxString message = ''.obs;

  // Error handling
  RxString errorMessage = ''.obs;
  RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // Network helper methods
  void enableNetworkHideLoader() {
    if (!isEnableNetwork.value) {
      isEnableNetwork.value = true;
    }
    update();
  }

  void disableNetworkLoaderByDefault() {
    if (isEnableNetwork.value) {
      isEnableNetwork.value = false;
    }
    update();
  }

  // Clear error state
  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }

  // Main method to fetch orders
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      clearError();

      final response = await Dioclient.get('/v1/order/getOrdersForUser');

      if (response.statusCode == 200) {
        final orderResponse = OrderResponse.fromJson(response.data);

        // Update observable values
        orders.value = orderResponse.orders;
        totalOrders.value = orderResponse.totalOrders;
        userId.value = orderResponse.userId;
        cartId.value = orderResponse.cartId;
        message.value = orderResponse.message;

        debugPrint('Orders fetched successfully: ${orders.length} orders');
      } else {
        _handleError('Failed to fetch orders. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      if (e.toString().contains('Unauthorized')) {
        _handleError('Please log in again to view your orders');
      } else if (e.toString().contains('Failed to fetch')) {
        _handleError('Network error. Please check your connection');
      } else {
        _handleError('Unable to fetch orders. Please try again');
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Handle errors
  void _handleError(String error) {
    hasError.value = true;
    errorMessage.value = error;
    debugPrint('Orders Error: $error');
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    await fetchOrders();
  }

  // Get order by ID
  Order? getOrderById(String orderId) {
    return orders.firstWhereOrNull((order) => order.id == orderId);
  }

  // Get orders by status
  List<Order> getOrdersByStatus(String status) {
    return orders
        .where((order) => order.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  // Get pending orders
  List<Order> get pendingOrders => getOrdersByStatus('pending');

  // Get completed orders
  List<Order> get completedOrders => getOrdersByStatus('completed');

  // Get cancelled orders
  List<Order> get cancelledOrders => getOrdersByStatus('cancelled');

  // Calculate total order value
  double get totalOrderValue {
    return orders.fold(0.0, (sum, order) => sum + order.totalPrice);
  }

  // Get order status color
  Color getOrderStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get order status display text
  String getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Order Placed';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status.toUpperCase();
    }
  }

  // Format date for display
  String formatOrderDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Format date with time
  String formatOrderDateTime(DateTime date) {
    return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  // Check if user is logged in
  bool get isUserLoggedIn => PrefManager.getString('isLogin') == 'yes';

  // Get current user ID
  String get currentUserId => PrefManager.getString('userId') ?? '';
}
