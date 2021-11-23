import 'package:flutter/material.dart';

import '../config/palette.dart';
import '../models/size.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.secondary_color,
      child: Column(
        children: const [
          SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
