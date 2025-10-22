import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/data/controller/categories/categories_controller.dart';
import 'package:saltandglitz/data/controller/dashboard/dashboard_controller.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/product/product_controller.dart';
import '../../../main_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final mainController = Get.put<MainController>(MainController());
  final dashboardController =
      Get.put<DashboardController>(DashboardController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());
  final productController = Get.put<ProductController>(ProductController());

  // Animation controllers
  late AnimationController _bubbleController;
  late AnimationController _logoController;
  late AnimationController _textController;

  // Animations
  late Animation<double> _bubbleAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;

  // Loading progress
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();

    // Set system UI overlay style for a clean look
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Initialize animation controllers
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize animations
    // Bubble pop animation - starts small and expands with ease out effect
    _bubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeOut,
    ));

    // Logo appears with scale and fade
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));

    // Text fades in
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    // Start animations sequentially
    _startAnimations();

    // Load data
    _loadData();
  }

  void _startAnimations() async {
    // Start bubble pop animation immediately and repeat
    _bubbleController.repeat(reverse: false);

    // After bubble animation, show logo
    await Future.delayed(const Duration(milliseconds: 400));
    _logoController.forward();

    // Then fade in text
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();
  }

  void _loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Simulate loading progress
      _updateLoadingProgress(0.1);

      await mainController.getDashboardJewelleryData();
      _updateLoadingProgress(0.3);

      for (int i = 0; i < bottomBannerList.length; i++) {
        String? media = bottomBannerList[i].bannerImage;
        dashboardController.handleMediaPlayback(media: media!, index: i);
      }
      _updateLoadingProgress(0.5);

      await categoriesController.getFemaleCategories();
      _updateLoadingProgress(0.7);

      print("Bottom banner length : ${getCategoryData.length}");

      await categoriesController.getMaleCategories();
      _updateLoadingProgress(0.9);

      print("Bottom banner length : ${getCategoryMaleData.length}");

      _updateLoadingProgress(1.0);

      // Add a small delay before navigation for smooth transition
      await Future.delayed(const Duration(milliseconds: 500));
    });

    mainController.splashScreenNavigation();
  }

  void _updateLoadingProgress(double progress) {
    setState(() {
      _loadingProgress = progress;
    });
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.buttonColor,
              ColorResources.buttonSecondColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Bubble pop animation from center
            AnimatedBuilder(
              animation: _bubbleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: size,
                  painter: BubblePopPainter(
                    progress: _bubbleAnimation.value,
                    color: Colors.white,
                  ),
                );
              },
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with scale and fade animation (no background circle)
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: Image.asset(
                        MyImages.ringOneImage,
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // App name with fade
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      LocalStrings.appName,
                      textAlign: TextAlign.center,
                      style: regularOverLarge.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.whiteColor,
                        fontSize: 36,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Tagline
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      'Crafted with Love',
                      textAlign: TextAlign.center,
                      style: regularDefault.copyWith(
                        color: ColorResources.whiteColor.withOpacity(0.8),
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Minimal loading indicator at bottom
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Column(
                    children: [
                      // Loading bar
                      Container(
                        width: 150,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 150 * _loadingProgress,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Loading text
                      Text(
                        'Loading...',
                        style: regularSmall.copyWith(
                          color: ColorResources.whiteColor.withOpacity(0.6),
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
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

// Custom painter for bubble pop animation
class BubblePopPainter extends CustomPainter {
  final double progress;
  final Color color;

  BubblePopPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        (size.width > size.height ? size.width : size.height) * 0.8;

    // Draw multiple expanding circles for dramatic bubble effect
    for (int i = 0; i < 4; i++) {
      final delay = i * 0.2;
      final circleProgress = (progress - delay).clamp(0.0, 1.0);

      if (circleProgress > 0) {
        final radius = maxRadius * circleProgress;
        final opacity = (1 - circleProgress) * 0.6;

        // Draw filled circle with gradient effect
        final fillPaint = Paint()
          ..color = Colors.white.withOpacity(opacity * 0.2)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
        canvas.drawCircle(center, radius, fillPaint);

        // Draw stroke circle for more visibility
        final strokePaint = Paint()
          ..color = Colors.white.withOpacity(opacity * 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
        canvas.drawCircle(center, radius, strokePaint);

        // Draw inner glow
        if (i == 0) {
          final glowPaint = Paint()
            ..color = const Color(0xFFFFD700).withOpacity(opacity * 0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 6
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
          canvas.drawCircle(center, radius, glowPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(BubblePopPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
