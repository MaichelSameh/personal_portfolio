import 'package:flutter/material.dart';

import '../config/palette.dart';
import '../models/size.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      height: _size.height(670),
      color: MyPalette.secondary_color,
      child: Column(
        children: const [
          SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
