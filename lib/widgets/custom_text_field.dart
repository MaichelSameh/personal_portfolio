import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/localization_controller.dart';
import '../models/size.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    double? width,
    double? height,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    bool expands = false,
    bool obscureText = false,
    TextEditingController? controller,
    BorderRadius? border,
    required String hintKey,
    String? headerKey,
    TextStyle? hintStyle,
    void Function(String)? onChange,
    Alignment? alignment,
    TextInputType keyboardType = TextInputType.text,
  }) : super(key: key) {
    _border = border;
    _controller = controller;
    _expands = expands;
    _hintKey = hintKey;
    _headerKey = headerKey;
    _hintStyle = hintStyle;
    _height = height;
    _maxLength = maxLength;
    _maxLines = maxLines;
    _minLines = minLines;
    _obscureText = obscureText;
    _width = width;
    _onChange = onChange;
    _keyboardType = keyboardType;
    _alignment = alignment;
  }

  late final void Function(String)? _onChange;

  late final BorderRadius? _border;
  late final TextEditingController? _controller;
  late final bool _expands;
  late final String? _headerKey;
  late final double? _height;
  late final String _hintKey;
  late final TextStyle? _hintStyle;
  late final TextInputType _keyboardType;
  late final int? _maxLength;
  late final int _maxLines;
  late final int? _minLines;
  late final bool _obscureText;
  late final double? _width;
  late final Alignment? _alignment;

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_headerKey != null)
          Text(
            Get.find<AppLocalizationController>()
                .getTranslatedValue(_headerKey!),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        if (_headerKey != null) SizedBox(height: _size.height(17)),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          child: Container(
            width: _width,
            height:
                _height ?? (_size.screensType == ScreensType.mobile ? 47 : 89),
            decoration: BoxDecoration(
              borderRadius: _border ?? BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
            ),
            padding: const EdgeInsets.all(15),
            alignment: _alignment ?? Alignment.center,
            child: TextField(
              maxLength: _maxLength,
              expands: _expands,
              maxLines: _expands ? null : _maxLines,
              minLines: _expands ? null : _minLines,
              controller: _controller,
              cursorColor: Colors.white.withOpacity(0.7),
              style: _size.textTheme(TextType.btn),
              textAlignVertical: TextAlignVertical.center,
              textDirection: Get.find<AppLocalizationController>().isRTLanguage
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              decoration: InputDecoration(
                hintTextDirection:
                    Get.find<AppLocalizationController>().isRTLanguage
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                errorBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: Get.find<AppLocalizationController>()
                    .getTranslatedValue(_hintKey),
                hintStyle: _hintStyle ??
                    Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color.fromRGBO(196, 198, 204, 1)),
                contentPadding: EdgeInsets.zero,
              ),
              obscureText: _obscureText,
              onChanged: _onChange,
              keyboardType: _keyboardType,
            ),
          ),
        ),
      ],
    );
  }
}
