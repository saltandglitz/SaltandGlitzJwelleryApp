import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
