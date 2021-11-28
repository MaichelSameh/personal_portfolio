import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../controllers/localization_controller.dart';

class CustomBorderedButton extends StatelessWidget {
  final void Function()? onTap;
  final String textKey;
  final double? width;
  final double? height;
  const CustomBorderedButton({
    Key? key,
    this.onTap,
    required this.textKey,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? _size.width(297),
          height: height ?? _size.height(96),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(_size.width(30)),
          ),
          alignment: Alignment.center,
          child: Text(
            Get.find<AppLocalizationController>().getTranslatedValue(textKey),
            style: _size.textTheme(TextType.btn),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onTap;
  final String textKey;
  final double? width;
  final double? height;
  const CustomElevatedButton(
      {Key? key, this.onTap, required this.textKey, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: MyPalette.secondary_color,
            borderRadius: BorderRadius.circular(_size.width(30)),
          ),
          width: width ?? _size.width(297),
          height: height ?? _size.height(96),
          alignment: Alignment.center,
          child: Text(
            Get.find<AppLocalizationController>().getTranslatedValue(textKey),
            style: _size.textTheme(TextType.btn),
          ),
        ),
      ),
    );
  }
}
