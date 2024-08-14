import 'package:flutter/material.dart';
import '../../core/utils/color_resources.dart';

class AppBarBackground extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final double additionalHeight;
  final bool isShowTabBar;
  final Widget? tabBarWidget;

  AppBarBackground({
    super.key,
    required this.child,
    this.additionalHeight = 0,
    this.isShowTabBar = false,
    this.tabBarWidget,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
          kToolbarHeight + (isShowTabBar ? additionalHeight : 0)),
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
            child,
            if (isShowTabBar && tabBarWidget != null) tabBarWidget!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isShowTabBar ? additionalHeight : 0));
}
