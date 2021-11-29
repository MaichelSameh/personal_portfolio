import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../config/palette.dart';
import '../models/size.dart';
import '../controllers/localization_controller.dart';
import '../widgets/widgets.dart';
import 'menu_bar_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key, required this.controller}) : super(key: key);

  final ItemScrollController controller;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int? hoveredIndex;
  Widget buildHeader(Size _size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          Get.find<AppLocalizationController>().getTranslatedValue(" Maichel "),
          style: TextStyle(
            fontSize: _size.screensType == ScreensType.pc
                ? 100
                : _size.screensType == ScreensType.tablet
                    ? 70
                    : 45,
            color: Colors.white,
            fontFamily: "Freestyle Script",
          ),
        ),
        buildNavigatorRow(_size, context),
      ],
    );
  }

  Widget buildNavigatorRow(Size _size, BuildContext context) {
    return _size.screensType == ScreensType.mobile
        ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                MenuBarScreen.route_name,
                arguments: widget.controller,
              );
            },
            child: Container(
                width: 80,
                height: _size.height(140),
                decoration: BoxDecoration(
                  color: MyPalette.secondary_color,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(_size.width(20)),
                    bottomRight: Radius.circular(_size.width(20)),
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/icons/menu_icon.svg")),
          )
        : SizedBox(
            height: _size.height(147),
            child: SizedBox(
              width: _size.width(500),
              child: Padding(
                padding: EdgeInsets.only(bottom: _size.height(35)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNavBarItem(_size, "about", true, 1),
                    buildNavBarItem(_size, "portfolio", false, 2),
                    buildNavBarItem(_size, "skills", false, 3),
                    buildNavBarItem(_size, "contact", false, 5),
                  ],
                ),
              ),
            ),
          );
  }

  buildNavBarItem(Size _size, String text, bool selected, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) {
        setState(() {
          hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.controller.jumpTo(index: index);
        },
        child: Container(
          width: _size.width(123),
          height: _size.height(160),
          decoration: BoxDecoration(
            color: hoveredIndex == index
                ? MyPalette.secondary_color.withOpacity(0.4)
                : selected
                    ? MyPalette.secondary_color
                    : Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_size.width(20)),
              bottomRight: Radius.circular(_size.width(20)),
            ),
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: _size.height(10)),
          child: Text(
            Get.find<AppLocalizationController>().getTranslatedValue(text),
            style: _size.textTheme(TextType.p),
          ),
        ),
      ),
    );
  }

  Widget buildInfoColumn(Size _size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          Get.find<AppLocalizationController>().getTranslatedValue("hello"),
          style: _size.textTheme(TextType.h2),
        ),
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("Maichel"),
          style: _size.textTheme(TextType.h1),
        ),
        Text(
          Get.find<AppLocalizationController>().getTranslatedValue("Sameh"),
          style: _size.textTheme(TextType.h1),
        ),
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("a_young") +
                    " ",
                style: _size.textTheme(TextType.p),
              ),
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("app") +
                    " ",
                style: _size.textTheme(TextType.p).copyWith(
                      color: MyPalette.secondary_color,
                    ),
              ),
              TextSpan(
                text: Get.find<AppLocalizationController>()
                        .getTranslatedValue("developer") +
                    "",
                style: _size.textTheme(TextType.p),
              ),
            ],
          ),
        ),
        const SizedBox(height: 70),
        _size.screensType == ScreensType.mobile
            ? Column(
                children: [
                  CustomElevatedButton(
                    textKey: "hire_me",
                    onTap: () {
                      widget.controller.jumpTo(index: 5);
                    },
                  ),
                  SizedBox(height: _size.height(30)),
                  CustomBorderedButton(
                    textKey: "portfolio",
                    onTap: () {
                      widget.controller.jumpTo(index: 2);
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  CustomElevatedButton(
                    textKey: "hire_me",
                    onTap: () {
                      widget.controller.jumpTo(index: 5);
                    },
                  ),
                  SizedBox(width: _size.width(30)),
                  CustomBorderedButton(
                    textKey: "portfolio",
                    onTap: () {
                      widget.controller.jumpTo(index: 2);
                    },
                  ),
                ],
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      padding: EdgeInsets.symmetric(horizontal: _size.width(87)),
      child: Column(
        children: [
          const SizedBox(width: double.infinity),
          buildHeader(_size, context),
          SizedBox(height: _size.height(42)),
          buildInfoColumn(_size),
        ],
      ),
    );
  }
}
