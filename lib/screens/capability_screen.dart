import 'package:flutter/material.dart';

import '../config/palette.dart';
import '../models/size.dart';

class CapabilityScreen extends StatelessWidget {
  const CapabilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Size(context);
    return Container(
      width: _size.screenWidth(),
      color: MyPalette.primary_color,
      child: Column(
        children: const [
          SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
