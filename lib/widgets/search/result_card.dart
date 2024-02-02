import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/custom_chip.dart';

class ResultCard extends StatelessWidget {
  final PreferenceResponse result;
  final void Function(int) onTap;
  final String? subtype;

  const ResultCard({
    super.key,
    required this.result,
    required this.onTap,
    this.subtype,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(result.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Row(
          children: [
            Image.network(
              result.image ?? '',
              width: 70,
              height: 70,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtype != null)
                      CustomChip(
                        label: result.subtype,
                      ),
                    Text(
                      result.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Icon(
              CustomIcons.arrow_forward,
              color: Dark.gray700,
            ),
          ],
        ),
      ),
    );
  }
}
