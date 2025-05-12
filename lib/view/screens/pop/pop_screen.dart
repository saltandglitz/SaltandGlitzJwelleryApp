import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';

class PopScreen extends StatefulWidget {
  const PopScreen({super.key});

  @override
  State<PopScreen> createState() => _PopScreenState();
}

class _PopScreenState extends State<PopScreen> {
  InAppWebViewController? webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://saltandglitz.com/plan-of-purchaes'),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(
                () {
                  isLoading = true;
                },
              );
            },
            onLoadStop: (controller, url) async {
              setState(
                () {
                  isLoading = false;
                },
              );
            },
            onLoadError: (controller, url, code, message) {
              setState(
                () {
                  isLoading = false;
                },
              );
            },
          ),

          // 👇 Loader overlay
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: ColorResources.buttonColor,
              ),
            ),
        ],
      ),
    );
  }
}
