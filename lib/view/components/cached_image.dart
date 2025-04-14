import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:shimmer/shimmer.dart';

///<<<--------------- Handle network image loading time and if error this time handle ---------------------->>>
class CachedCommonImage extends StatelessWidget {
  String? networkImageUrl;
  double? height;
  double? width;

  CachedCommonImage({
    super.key,
    this.networkImageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: networkImageUrl ?? "",
      fit: BoxFit.cover,
      memCacheHeight: 460,
      memCacheWidth: 500,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Shimmer.fromColors(
        baseColor: ColorResources.baseColor,
        highlightColor: ColorResources.highlightColor,
        child: Container(
          height: height ?? 200.0, // Adjust based on your layout
          width: width ?? 200.0, // Adjust based on your layout
          color: ColorResources.whiteColor,
        ),
      ),

      // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      //   child: CircularProgressIndicator(value: downloadProgress.progress),
      // ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
    );
  }
}
