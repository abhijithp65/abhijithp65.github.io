import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryColor,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: Sizes.HEIGHT_8),
        Container(
          width: 40, height: 3,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
