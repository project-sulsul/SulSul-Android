import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';

class AlcoholCard extends StatelessWidget {
  final String text;
  final String image;
  final int id;
  final bool isSelected;
  final void Function(int)? onPress;

  const AlcoholCard({
    super.key,
    required this.text,
    required this.image,
    required this.id,
    required this.isSelected,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress!(id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Main.main : Dark.gray050,
          border: Border.all(
            width: 1,
            color: isSelected ? Main.main : Dark.gray500,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            children: [
              Image.network(
                image,
                width: 90,
                height: 90,
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
