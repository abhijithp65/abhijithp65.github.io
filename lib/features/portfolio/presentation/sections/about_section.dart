import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/core/widgets/app_toast.dart';
import 'package:personal_portfolio/features/portfolio/presentation/widgets/about_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            _SectionHeader(tag: StringConst.ABOUT_ME, title: 'About Me'),
            const SizedBox(height: 56),
            compact
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AboutText(),
                      const SizedBox(height: 40),
                      _StatsGrid(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: AboutText()),
                      const SizedBox(width: 60),
                      Expanded(flex: 4, child: _RightPanel()),
                    ],
                  ),
            const SizedBox(height: 56),
            _ExperienceTimeline(),
          ],
        ),
      ),
    );
  }
}

class _RightPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_StatsGrid(), const SizedBox(height: 24), _TraitsCard()],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  static const _stats = [
    {
      'value': '2+',
      'label': 'Years Experience',
      'icon': Icons.work_history_rounded,
    },
    {
      'value': '5+',
      'label': 'Apps on Play Store',
      'icon': Icons.android_rounded,
    },
    {'value': '50K+', 'label': 'Active Users', 'icon': Icons.people_rounded},
    {'value': '60%', 'label': 'Faster KYC', 'icon': Icons.speed_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: _stats
          .asMap()
          .entries
          .map(
            (e) => _StatCard(
              value: e.value['value'] as String,
              label: e.value['label'] as String,
              icon: e.value['icon'] as IconData,
              index: e.key,
            ),
          )
          .toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final int index;
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 18),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 10, height: 1.3),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 200 + index * 80))
        .scale(begin: const Offset(0.8, 0.8));
  }
}

class _TraitsCard extends StatelessWidget {
  static const _traits = [
    'Clean Architecture',
    'Security-First',
    'Performance Focused',
    'Team Player',
    'Agile / Scrum',
    'On-time Delivery',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Core Values',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _traits
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTint,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.25),
                      ),
                    ),
                    child: Text(
                      t,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0);
  }
}

class _ExperienceTimeline extends StatefulWidget {
  @override
  State<_ExperienceTimeline> createState() => _ExperienceTimelineState();
}

class _ExperienceTimelineState extends State<_ExperienceTimeline> {
  late final List<GlobalKey> _dotKeys;

  @override
  void initState() {
    super.initState();
    _dotKeys = List.generate(Data.experience.length, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          tag: StringConst.EXPERIENCE,
          title: StringConst.MY_EXPERIENCE,
        ),
        const SizedBox(height: 32),
        _TimelineRows(dotKeys: _dotKeys),
      ],
    );
  }
}

class _TimelineRows extends StatefulWidget {
  final List<GlobalKey> dotKeys;
  const _TimelineRows({required this.dotKeys});

  @override
  State<_TimelineRows> createState() => _TimelineRowsState();
}

class _TimelineRowsState extends State<_TimelineRows> {
  List<Offset> _dotOffsets = [];
  final _columnKey = GlobalKey();

  void _computeOffsets() {
    final columnBox =
        _columnKey.currentContext?.findRenderObject() as RenderBox?;
    if (columnBox == null) return;

    final offsets = <Offset>[];
    for (final key in widget.dotKeys) {
      final dotBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (dotBox == null) {
        offsets.add(Offset.zero);
        continue;
      }
      final pos = dotBox.localToGlobal(
        dotBox.size.center(Offset.zero),
        ancestor: columnBox,
      );
      offsets.add(pos);
    }

    if (mounted) setState(() => _dotOffsets = offsets);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _computeOffsets());
  }

  @override
  Widget build(BuildContext context) {
    final entries = Data.experience.asMap().entries.toList();

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _computeOffsets());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Stack(
          key: _columnKey,
          children: [
            if (_dotOffsets.length == entries.length)
              Positioned.fill(
                child: CustomPaint(
                  painter: _SpineLinePainter(
                    dotOffsets: _dotOffsets,
                    color: AppColors.cardBorder,
                  ),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: entries.map((entry) {
                final isLast = entry.key == entries.length - 1;
                final dotColor = entry.value.type == 'full-time'
                    ? AppColors.primaryColor
                    : entry.value.type == 'freelance'
                    ? AppColors.dangerColor.withOpacity(0.9)
                    : AppColors.captionColor;

                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 32,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Center(
                            child: Container(
                              key: widget.dotKeys[entry.key],
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.backgroundColor,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ExpCard(exp: entry.value, index: entry.key),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpineLinePainter extends CustomPainter {
  final List<Offset> dotOffsets;
  final Color color;
  const _SpineLinePainter({required this.dotOffsets, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (dotOffsets.length < 2) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < dotOffsets.length - 1; i++) {
      final start = dotOffsets[i].translate(0, 7);
      final end = dotOffsets[i + 1].translate(0, -7);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(_SpineLinePainter old) =>
      old.dotOffsets != dotOffsets || old.color != color;
}

class _ExpCard extends StatefulWidget {
  final ExperienceData exp;
  final int index;
  const _ExpCard({required this.exp, required this.index});
  @override
  State<_ExpCard> createState() => _ExpCardState();
}

class _ExpCardState extends State<_ExpCard> {
  bool _expanded = false;

  Color get _typeColor {
    switch (widget.exp.type) {
      case 'freelance':
        return AppColors.dangerColor;
      case 'internship':
        return AppColors.captionColor;
      default:
        return AppColors.primaryColor;
    }
  }

  String get _typeLabel {
    switch (widget.exp.type) {
      case 'freelance':
        return 'Freelance';
      case 'internship':
        return 'Internship';
      default:
        return 'Full-time';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.exp;
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.04),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 6,
                children: [
                  Text(
                    exp.role,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _typeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _typeColor.withOpacity(0.4)),
                    ),
                    child: Text(
                      _typeLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _typeColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    AppToast.info(
                      'Opening ${exp.company}…',
                      title: 'Redirecting',
                    );
                    launchUrl(
                      Uri.parse(exp.companyUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CompanyLogo(
                        company: exp.company,
                        logoAsset: exp.logoAsset,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          exp.company,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor
                                    .withOpacity(0.5),
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.open_in_new_rounded,
                        size: 12,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 11,
                        color: AppColors.captionColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        exp.period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.captionColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 11,
                        color: AppColors.captionColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        exp.location,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.captionColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(color: AppColors.cardBorder, height: 1),
              const SizedBox(height: 12),
              ...exp.points
                  .take(_expanded ? exp.points.length : 2)
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: _typeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(height: 1.65, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              if (exp.points.length > 2) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _expanded
                              ? 'Show less'
                              : 'Show more (${exp.points.length - 2} more)',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          _expanded
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                          size: 14,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (widget.exp.type == 'full-time') ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _AchievementBadge(
                      icon: Icons.security_rounded,
                      title: 'Zero Security Incidents',
                      sub: 'SSL Pinning across 4 apps',
                    ),
                    _AchievementBadge(
                      icon: Icons.emoji_events_rounded,
                      title: 'Ahead of Schedule',
                      sub: '3 features, 2 weeks early',
                    ),
                  ],
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 150 * widget.index),
          duration: 500.ms,
        )
        .slideY(begin: 0.1, end: 0);
  }
}

class _AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  const _AchievementBadge({
    required this.icon,
    required this.title,
    required this.sub,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 16),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Text(
                  sub,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.captionColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String tag, title;
  const _SectionHeader({required this.tag, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tag.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.primaryColor,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 10),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0);
  }
}

class _CompanyLogo extends StatelessWidget {
  final String company;
  final String? logoAsset;
  const _CompanyLogo({required this.company, this.logoAsset});

  Color _bgColor() {
    const colors = [
      Color(0xFF15B572),
      Color(0xFF007AFF),
      Color(0xFFFF6B35),
      Color(0xFF9B59B6),
      Color(0xFF1ABC9C),
      Color(0xFFE74C3C),
    ];
    final idx = company.isNotEmpty ? company.codeUnitAt(0) % colors.length : 0;
    return colors[idx];
  }

  @override
  Widget build(BuildContext context) {
    final initial = company.isNotEmpty ? company[0].toUpperCase() : '?';
    final color = _bgColor();

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: logoAsset != null
          ? Image.asset(
              logoAsset!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  _LetterAvatar(initial: initial, color: color),
            )
          : _LetterAvatar(initial: initial, color: color),
    );
  }
}

class _LetterAvatar extends StatelessWidget {
  final String initial;
  final Color color;
  const _LetterAvatar({required this.initial, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color.withOpacity(0.15),
      child: Text(
        initial,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
    );
  }
}
