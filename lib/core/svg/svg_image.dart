import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  const SvgImage({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetPath);
  }
}
