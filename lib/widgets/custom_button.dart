import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../controllers/localization_controller.dart';

class CustomBorderedButton extends StatelessWidget {
  final void Function()? onTap;
  final String textKey;
  final double horizontalPadding;
  final double verticalPadding;
  const CustomBorderedButton({
    Key? key,
    this.onTap,
    required this.textKey,
    this.horizontalPadding = 40,
    this.verticalPadding = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      cursor: MouseCursor.uncontrolled,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _size.height(verticalPadding),
          horizontal: _size.width(horizontalPadding),
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(_size.width(60)),
        ),
        child: Text(
          Get.find<AppLocalizationController>().getTranslatedValue(textKey),
          style: _size.textTheme(TextType.btn),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onTap;
  final String textKey;
  final double horizontalPadding;
  final double verticalPadding;
  const CustomElevatedButton({
    Key? key,
    this.onTap,
    required this.textKey,
    this.horizontalPadding = 40,
    this.verticalPadding = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      cursor: MouseCursor.uncontrolled,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _size.height(verticalPadding),
          horizontal: _size.width(horizontalPadding),
        ),
        decoration: BoxDecoration(
          color: MyPalette.third_color,
          borderRadius: BorderRadius.circular(_size.width(60)),
        ),
        child: Text(
          Get.find<AppLocalizationController>().getTranslatedValue(textKey),
          style: _size.textTheme(TextType.btn),
        ),
      ),
    );
  }
}
