import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/categories/categories_controller.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
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
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _rotationController;
  late AnimationController _shimmerController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _shimmerAnimation;

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
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _shimmerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.linear,
    ));

    // Start animations
    _startAnimations();

    // Load data
    _loadData();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _slideController.forward();
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
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _rotationController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorResources.buttonColor,
              ColorResources.buttonSecondColor.withOpacity(0.9),
              ColorResources.buttonColor.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background pattern
            _buildAnimatedBackground(),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Animated logo/ring
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Rotating glow effect
                            AnimatedBuilder(
                              animation: _rotationAnimation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotationAnimation.value,
                                  child: Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: SweepGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.0),
                                          Colors.white.withOpacity(0.3),
                                          Colors.white.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Center ring image
                            Image.asset(
                              MyImages.ringOneImage,
                              height: 120,
                              width: 120,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Brand name with shimmer effect
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedBuilder(
                        animation: _shimmerAnimation,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: const [
                                  Colors.white,
                                  Colors.white,
                                  Color(0xFFFFD700),
                                  Colors.white,
                                  Colors.white,
                                ],
                                stops: [
                                  0.0,
                                  _shimmerAnimation.value - 0.3,
                                  _shimmerAnimation.value,
                                  _shimmerAnimation.value + 0.3,
                                  1.0,
                                ],
                                tileMode: TileMode.clamp,
                              ).createShader(bounds);
                            },
                            child: Text(
                              LocalStrings.appName,
                              textAlign: TextAlign.center,
                              style: regularOverLarge.copyWith(
                                fontWeight: FontWeight.w300,
                                color: ColorResources.whiteColor,
                                fontSize: 42,
                                letterSpacing: 3,
                                height: 1.2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Tagline
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Crafted with Love',
                        textAlign: TextAlign.center,
                        style: regularDefault.copyWith(
                          color: ColorResources.whiteColor.withOpacity(0.8),
                          fontSize: 14,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Modern loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 200,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 200 * _loadingProgress,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFD700),
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom decorative element
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeatureIcon(Icons.workspace_premium, 'Premium'),
                        const SizedBox(width: 30),
                        _buildFeatureIcon(Icons.verified, 'Certified'),
                        const SizedBox(width: 30),
                        _buildFeatureIcon(
                            Icons.local_shipping, 'Fast Delivery'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: BackgroundPatternPainter(
            animation: _rotationAnimation.value,
          ),
        );
      },
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: ColorResources.whiteColor.withOpacity(0.9),
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: regularSmall.copyWith(
            color: ColorResources.whiteColor.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// Custom painter for animated background pattern
class BackgroundPatternPainter extends CustomPainter {
  final double animation;

  BackgroundPatternPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw animated geometric patterns
    for (int i = 0; i < 3; i++) {
      final offset = animation * 50 + i * 100;
      final radius = 100 + i * 50;

      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.2),
        radius + offset % 200,
        paint,
      );

      canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.8),
        radius + offset % 200,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BackgroundPatternPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
