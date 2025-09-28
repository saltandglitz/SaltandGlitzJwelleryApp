import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saltandglitz/data/controller/in_app_web_view/in_app_web_view_controller.dart';

import '../../../core/utils/color_resources.dart';

class InAppWebViewScreen extends StatefulWidget {
  InAppWebViewScreen({super.key});

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  final inAppWebViewExtendController =
      Get.put<InAppWebViewExtendController>(InAppWebViewExtendController());

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      inAppWebViewExtendController.webUrl = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InAppWebViewExtendController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
// Background color (Light grey)
              Container(color: ColorResources.baseColor),
              // Set background color here),
              // InAppWebView
              InAppWebView(
                onProgressChanged:
                    (InAppWebViewController inAppWebViewController,
                        int progress) {
                  controller.setProgress(progress);
                },
                onWebViewCreated:
                    (InAppWebViewController inAppWebViewController) {
                  controller.setWebViewController(inAppWebViewController);
                },
                onPermissionRequest: (InAppWebViewController controller,
                    PermissionRequest permissionRequest) async {
                  // Handle permissions
                  if (permissionRequest.resources
                      .contains(PermissionResourceType.MICROPHONE)) {
                    final PermissionStatus permissionStatus =
                        await Permission.microphone.request();
                    if (permissionStatus.isGranted) {
                      return PermissionResponse(
                        resources: permissionRequest.resources,
                        action: PermissionResponseAction.GRANT,
                      );
                    } else if (permissionStatus.isDenied) {
                      return PermissionResponse(
                        resources: permissionRequest.resources,
                        action: PermissionResponseAction.DENY,
                      );
                    }
                  }
                  return null;
                },
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(
                    Uri.parse(controller.webUrl),
                  ),
                ),
              ),

              // Progress loader, centered in the screen
              Obx(
                () {
                  final double progress = controller.progress.value;
                  if (progress < 1) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.buttonColor,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
