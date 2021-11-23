import 'package:flutter/material.dart';

class DottelsContainer extends StatelessWidget {
  final double width;
  final double height;
  const DottelsContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView.builder(
        itemBuilder: (_, __) {
          return SizedBox(
            height: 16,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.1),
                    shape: BoxShape.circle,
                  ),
                );
              },
              itemCount: width ~/ 16,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
            ),
          );
        },
        itemCount: height ~/ 16,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
