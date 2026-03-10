import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '<',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 58,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IBM Plex Mono',
                  shadows: [
                    Shadow(
                      color: AppColors.primaryColor.withOpacity(0.9),
                      blurRadius: 24,
                    ),
                    Shadow(
                      color: AppColors.primaryColor.withOpacity(0.4),
                      blurRadius: 48,
                    ),
                  ],
                ),
              ),
              const TextSpan(
                text: 'AP',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 58,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IBM Plex Mono',
                ),
              ),
              TextSpan(
                text: '/>',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 58,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IBM Plex Mono',
                  shadows: [
                    Shadow(
                      color: AppColors.primaryColor.withOpacity(0.9),
                      blurRadius: 24,
                    ),
                    Shadow(
                      color: AppColors.primaryColor.withOpacity(0.4),
                      blurRadius: 48,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
