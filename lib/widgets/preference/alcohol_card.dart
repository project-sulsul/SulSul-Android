import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';

class AlcoholCard extends StatelessWidget {
  final String text;
  final String image;
  final int id;
  final bool isSelected;
  final void Function(int)? onTap;

  const AlcoholCard({
    super.key,
    required this.text,
    this.image =
        'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
    required this.id,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Main.main : Dark.black,
          border: Border.all(
            width: 1,
            color: isSelected ? Main.main : Dark.gray500,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.42,
          child: Column(
            children: [
              Image.network(
                image,
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Dark.black : Dark.gray500,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
