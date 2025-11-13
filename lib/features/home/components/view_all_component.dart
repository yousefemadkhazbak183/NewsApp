import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({super.key, required this.title, this.titleColor, required this.onTap});

  final String title;
  final Color? titleColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: titleColor ?? AppColor.whiteColor, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          InkWell(
            onTap: () => onTap(),
            child: Text(
              'View All',
              style: TextStyle(
                color: titleColor ?? AppColor.whiteColor,
                decoration: TextDecoration.underline,
                decorationColor: titleColor ?? AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
