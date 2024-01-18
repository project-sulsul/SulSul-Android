import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';

class NoticeCount extends StatelessWidget {
  final int count;

  const NoticeCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 116,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: ShapeDecoration(
                color: Dark.gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count개까지 고를 수 있어요!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Dark.gray700,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 0.16,
                      letterSpacing: -0.15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 27,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(-3.14),
              child: Container(
                width: 10,
                height: 10,
                decoration: const ShapeDecoration(
                  color: Dark.gray200,
                  shape: StarBorder.polygon(sides: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
