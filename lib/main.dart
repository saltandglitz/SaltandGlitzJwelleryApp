import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/main_controller.dart';
import 'data/controller/bottom_bar/bottom_bar_controller.dart';
import 'local_storage/pref_manager.dart';
final mainController = Get.put<MainController>(MainController());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefaultFirebase();
  await PrefManager.init();
  mainController.fetchStringFirebaseData();
  // Register BottomBarController globally
  Get.put(BottomBarController(), permanent: true);
  runApp(
    const MyApp(),
  );
}

/// Initialize firebase information provide using this method
Future<void> initializeDefaultFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBzAxmzO79K7ih_VNUMt5ryhg14bvqk9n0',
      appId: '1:710485598853:android:b3d9c4d502f5f932baffec',
      messagingSenderId: '710485598853',
      projectId: 'saltand-glitz',
    ),
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
      initialRoute: RouteHelper.splashScreen,
      theme: ThemeData.light(),
      getPages: RouteHelper().routes,
      builder: EasyLoading.init(),
    );
  }
}
