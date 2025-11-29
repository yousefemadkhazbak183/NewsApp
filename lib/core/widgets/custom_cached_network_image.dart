import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imageUrl, this.height, this.width});
  final String imageUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height ?? 80,
      width: width ?? 140,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(width: width ?? 140, height: height ?? 80, color: Colors.white),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
