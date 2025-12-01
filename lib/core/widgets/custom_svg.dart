import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({super.key, required this.path, this.isColorFilter = true, this.width, this.height});
  const CustomSvgPicture.withoutFilterColor({super.key, required this.path, this.width, this.height})
    : isColorFilter = false;
  final String path;
  final bool isColorFilter;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: isColorFilter ? ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}
