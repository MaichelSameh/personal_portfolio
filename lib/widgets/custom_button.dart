import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../controllers/localization_controller.dart';

class CustomBorderedButton extends StatefulWidget {
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
  State<CustomBorderedButton> createState() => _CustomBorderedButtonState();
}

class _CustomBorderedButtonState extends State<CustomBorderedButton> {
  Color color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) {
        setState(() {
          color = MyPalette.secondary_color.withOpacity(0.4);
        });
      },
      onExit: (_) {
        setState(() {
          color = Colors.transparent;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.width ??
              (_size.screensType == ScreensType.mobile ? 250 : 297),
          height: widget.height ??
              (_size.screensType == ScreensType.mobile ? 62 : 96),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            Get.find<AppLocalizationController>()
                .getTranslatedValue(widget.textKey),
            style: _size.textTheme(TextType.btn),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatefulWidget {
  final void Function()? onTap;
  final String textKey;
  final double? width;
  final double? height;
  const CustomElevatedButton(
      {Key? key, this.onTap, required this.textKey, this.height, this.width})
      : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  Color color = MyPalette.secondary_color;
  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return MouseRegion(
      onHover: (_) {
        setState(() {
          color = MyPalette.secondary_color.withOpacity(0.4);
        });
      },
      onExit: (_) {
        setState(() {
          color = MyPalette.secondary_color;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          width: widget.width ??
              (_size.screensType == ScreensType.mobile ? 250 : 297),
          height: widget.height ??
              (_size.screensType == ScreensType.mobile ? 62 : 96),
          alignment: Alignment.center,
          child: Text(
            Get.find<AppLocalizationController>()
                .getTranslatedValue(widget.textKey),
            style: _size.textTheme(TextType.btn),
          ),
        ),
      ),
    );
  }
}
