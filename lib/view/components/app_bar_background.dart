import 'package:flutter/material.dart';
import '../../core/utils/color_resources.dart';

class AppBarBackground extends StatelessWidget implements PreferredSizeWidget {
  final AppBar child;
  final double additionalHeight;
  final bool isShowTabBar;
  final Widget? tabBarWidget;
  final Widget? bottomWidget; // 👈 Added to include search or any widget

  const AppBarBackground({
    super.key,
    required this.child,
    this.additionalHeight = 0,
    this.isShowTabBar = false,
    this.tabBarWidget,
    this.bottomWidget, // 👈 Added
  });

  @override
  Widget build(BuildContext context) {
    final AppBar appBarWithLogo = AppBar(
      leading: child.leading,
      actions: child.actions,
      automaticallyImplyLeading: child.automaticallyImplyLeading,
      backgroundColor: child.backgroundColor,
      elevation: child.elevation,
      titleSpacing: child.titleSpacing,
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo_website.png',
        height: 18,
        fit: BoxFit.contain,
      ),
    );

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorResources.borderColor.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            appBarWithLogo,
            if (bottomWidget != null)
              bottomWidget!, // 👈 Add the bottom widget like a search bar
            if (isShowTabBar && tabBarWidget != null) tabBarWidget!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight +
            (isShowTabBar ? additionalHeight : 0) +
            (bottomWidget != null
                ? 60
                : 0), // 👈 Adjust height if bottomWidget exists
      );
}
