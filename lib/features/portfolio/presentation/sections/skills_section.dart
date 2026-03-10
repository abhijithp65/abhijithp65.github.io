import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final compact = sw < 700;
    final px = compact ? 20.0 : (sw < 900 ? 40.0 : 80.0);

    return ColoredBox(
      color: AppColors.accentColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: px, vertical: 90),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConst.MY_SKILLS.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryColor,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${StringConst.SKILLS_TITLE_1} ${StringConst.SKILLS_TITLE_2}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Text(
                    StringConst.SKILLS_DESC,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 52),

            compact
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SkillBars(),
                      const SizedBox(height: 40),
                      _TechGrid(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _SkillBars()),
                      const SizedBox(width: 60),
                      Expanded(child: _TechGrid()),
                    ],
                  ),

            const SizedBox(height: 52),
            _FullSkillsList(),
          ],
        ),
      ),
    );
  }
}

class _SkillBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proficiency',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primaryColor,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        ...Data.skillLevelData.asMap().entries.map(
          (e) => _SkillBar(
            skill: e.value.skill,
            level: e.value.level,
            index: e.key,
          ),
        ),
      ],
    );
  }
}

class _SkillBar extends StatefulWidget {
  final String skill;
  final int level;
  final int index;
  const _SkillBar({
    required this.skill,
    required this.level,
    required this.index,
  });
  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: 1400.ms);
    _anim = Tween<double>(
      begin: 0,
      end: widget.level / 100,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 400 + widget.index * 120), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.skill,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (_, __) => Text(
                      '${(_anim.value * 100).toInt()}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 7,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AnimatedBuilder(
                  animation: _anim,
                  builder: (_, __) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _anim.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primary200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 200 + widget.index * 80))
        .slideX(begin: -0.15, end: 0);
  }
}

class _TechGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primaryColor,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: Data.techStack
              .asMap()
              .entries
              .map(
                (e) => _TechChip(
                  label: e.value['label'] as String,
                  icon: e.value['icon'] as IconData,
                  index: e.key,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _TechChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;
  const _TechChip({
    required this.label,
    required this.icon,
    required this.index,
  });
  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => _h = true),
          onExit: (_) => setState(() => _h = false),
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _h ? AppColors.primaryTint : AppColors.cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _h ? AppColors.primaryColor : AppColors.cardBorder,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 14,
                  color: _h ? AppColors.primaryColor : AppColors.captionColor,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _h
                          ? AppColors.primaryColor
                          : AppColors.captionColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 80 * widget.index))
        .scale(begin: const Offset(0.85, 0.85));
  }
}

class _FullSkillsList extends StatelessWidget {
  static const _allSkills = [
    'Dart',
    'Flutter',
    'Flutter Web',
    'BLoC',
    'Provider',
    'Riverpod',
    'Clean Architecture',
    'MVVM',
    'REST',
    'HTTP',
    'Dio',
    'SSL Pinning',
    'Token-based Auth',
    'InAppWebView',
    'Deep Linking',
    'Biometric Auth',
    'FCM',
    'Local Storage',
    'Shared Preferences',
    'MySQL',
    'Hive',
    'GetIt',
    'Lottie',
    'Cached Network Image',
    'Flutter Secure Storage',
    'Localizations',
    'Git',
    'GitHub Actions',
    'CI/CD',
    'Postman',
    'Google Play Console',
    'Firebase',
    'Firestore',
    'FCM',
    'Analytics',
    'Hyperverge',
    'Digio',
    'CleverTap',
    'DevRev',
    'Setu OneMoney',
    'Unit Testing',
    'Widget Testing',
    'Agile',
    'Scrum',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'All Technologies & Tools',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.captionColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: _allSkills
              .map(
                (s) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Text(
                    s,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.captionColor,
                      fontSize: 11,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }
}
