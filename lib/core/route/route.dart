import 'package:get/get.dart';
import 'package:saltandglitz/view/screens/add_to_cart/add_to_cart_screen.dart';
import 'package:saltandglitz/view/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:saltandglitz/view/screens/create_account/create_account_screen.dart';
import 'package:saltandglitz/view/screens/dashboard/dashboard_screen.dart';
import 'package:saltandglitz/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:saltandglitz/view/screens/forget_password/forget_password.dart';
import 'package:saltandglitz/view/screens/in_app_webview/in_app_webview_screen.dart';

import 'package:saltandglitz/view/screens/login/login_screen.dart';
import 'package:saltandglitz/view/screens/set_otp/set_otp_screen.dart';
import 'package:saltandglitz/view/screens/set_password/set_password_screen.dart';
import '../../view/screens/categories/categories_screen.dart';
import '../../view/screens/categories/kids_categories.dart';
import '../../view/screens/categories/men_categories_screen.dart';
import '../../view/screens/categories/women_categories_screen.dart';
import '../../view/screens/collection/collection_screen.dart';
import '../../view/screens/collection_filter/collection_filter_screen.dart';
import '../../view/screens/gift/gift_screen.dart';
import '../../view/screens/my_account/my_account_screen.dart';
import '../../view/screens/orders/orders_screen.dart';
import '../../view/screens/orders/order_detail_screen.dart';
import '../../view/screens/payment/payment_screen.dart';
import '../../view/screens/place_order/place_order_screen.dart';
import '../../view/screens/pop/pop_screen.dart';
import '../../view/screens/product/product_screen.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/screens/wishlist/wishlist_screen.dart';

class RouteHelper {
  static const String bottomBarScreen = "/bottom_bar_screen";
  static const String dashboardScreen = "/dashboard_screen";
  static const String addCartScreen = "/add_to_cart_screen";
  static const String categoriesScreen = "/categories_screen";
  static const String womenCategoriesScreen = "/women_categories_screen";
  static const String menCategoriesScreen = "/men_categories_screen";
  static const String kidsCategoriesScreen = "/kids_categories_screen";
  static const String wishlistScreen = "/wishlist_screen";
  static const String collectionScreen = "/collection_screen";
  static const String collectionFilterScreen = "/collection_filter_screen";
  static const String productScreen = "/product_screen";
  static const String myAccountScreen = "/my_account_screen";
  static const String loginScreen = "/login_screen";
  static const String createAccountScreen = "/create_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String setPasswordScreen = "/set_password_screen";
  static const String setOtpScreen = "/set_otp_screen";
  static const String forgetPasswordScreen = "/forget_password_screen";
  static const String splashScreen = "/splash_screen";
  static const String placeOrder = "/place_order";
  static const String giftScreen = "/gift_screen";
  static const String paymentScreen = "/payment_screen";
  static const String inAppWebViewScreen = "/in_app_web_view_screen";
  static const String popScreen = "/pop_screen";
  static const String ordersScreen = "/orders_screen";
  static const String orderDetailScreen = "/order_detail_screen";

  List<GetPage> routes = [
    GetPage(name: bottomBarScreen, page: () => const BottomBarScreen()),
    GetPage(name: dashboardScreen, page: () => const DashboardScreen()),
    GetPage(name: addCartScreen, page: () => const AddToCartScreen()),
    GetPage(name: categoriesScreen, page: () => CategoriesScreen()),
    GetPage(
        name: womenCategoriesScreen, page: () => const WomenCategoriesScreen()),
    GetPage(name: menCategoriesScreen, page: () => const MenCategoriesScreen()),
    GetPage(
        name: kidsCategoriesScreen, page: () => const KidsCategoriesScreen()),
    GetPage(name: wishlistScreen, page: () => const WishlistScreen()),
    GetPage(name: collectionScreen, page: () => const CollectionScreen()),
    GetPage(
        name: collectionFilterScreen,
        page: () => const CollectionFilterScreen()),
    GetPage(name: productScreen, page: () => const ProductScreen()),
    GetPage(name: myAccountScreen, page: () => const MyAccountScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: createAccountScreen, page: () => const CreateAccountScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: setPasswordScreen, page: () => const SetPassword()),
    GetPage(name: setOtpScreen, page: () => const SetOtp()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPassword()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: placeOrder, page: () => const PlaceOrderScreen()),
    GetPage(name: giftScreen, page: () => const GiftScreen()),
    GetPage(name: paymentScreen, page: () => const PaymentScreen()),
    GetPage(name: inAppWebViewScreen, page: () => InAppWebViewScreen()),
    GetPage(name: popScreen, page: () => const PopScreen()),
    GetPage(name: ordersScreen, page: () => const OrdersScreen()),
    GetPage(name: orderDetailScreen, page: () => const OrderDetailScreen()),
  ];
}
