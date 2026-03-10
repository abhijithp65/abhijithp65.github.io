import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class AboutText extends StatelessWidget {
  const AboutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, I\'m Abhijith 👋',
          style: Theme.of(context).textTheme.headlineSmall,
        ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 20),
        ...StringConst.ABOUT_ME_DESC
            .split('\n\n')
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:
                    Text(
                          e.value,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(height: 1.8),
                        )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 200 + e.key * 100),
                        )
                        .slideX(begin: -0.1, end: 0),
              ),
            ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.school_rounded,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Education',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _EduRow(
                degree: 'Master of Computer Applications',
                year: '2020–2023',
                uni: 'Kannur University',
              ),
              const SizedBox(height: 8),
              _EduRow(
                degree: 'Bachelor of Computer Applications',
                year: '2017–2020',
                uni: 'Kannur University',
              ),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }
}

class _EduRow extends StatelessWidget {
  final String degree, year, uni;
  const _EduRow({required this.degree, required this.year, required this.uni});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                degree,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '$uni · $year',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.captionColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
