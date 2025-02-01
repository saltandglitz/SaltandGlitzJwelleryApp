import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'data/controller/bottom_bar/bottom_bar_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register BottomBarController globally
  Get.put(BottomBarController(), permanent: true);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: LocalStrings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.bottomBarScreen,
      theme: ThemeData.light(),
      getPages: RouteHelper().routes,
    );
  }
}
