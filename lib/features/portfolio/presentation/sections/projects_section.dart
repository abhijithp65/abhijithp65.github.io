import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/core/widgets/app_toast.dart';
import 'package:personal_portfolio/core/utils/functions.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final compact = sw < 700;
    final px = compact ? 20.0 : (sw < 900 ? 40.0 : 80.0);

    final cols = compact ? 1 : (sw < 1100 ? 2 : 3);
    final initialCount = cols * 2;
    final visibleProjects = _showAll
        ? Data.projects
        : Data.projects.take(initialCount).toList();
    final hasMore = Data.projects.length > initialCount;

    return ColoredBox(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: px, vertical: 90),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConst.MY_WORKS.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryColor,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  StringConst.MEET_MY_PROJECTS,
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
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Text(
                    StringConst.PROJECTS_DESC,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 52),

            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              child: compact
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: visibleProjects
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _ProjectCard(
                                project: e.value,
                                index: e.key,
                                cardWidth: double.infinity,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: visibleProjects
                          .asMap()
                          .entries
                          .map(
                            (e) => _ProjectCard(
                              project: e.value,
                              index: e.key,
                              cardWidth: 300,
                            ),
                          )
                          .toList(),
                    ),
            ),

            if (hasMore) ...[
              const SizedBox(height: 40),
              _ShowMoreButton(
                expanded: _showAll,
                remaining: Data.projects.length - initialCount,
                onTap: () => setState(() => _showAll = !_showAll),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShowMoreButton extends StatefulWidget {
  final bool expanded;
  final int remaining;
  final VoidCallback onTap;
  const _ShowMoreButton({
    required this.expanded,
    required this.remaining,
    required this.onTap,
  });
  @override
  State<_ShowMoreButton> createState() => _ShowMoreButtonState();
}

class _ShowMoreButtonState extends State<_ShowMoreButton> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _h = true),
        onExit: (_) => setState(() => _h = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
            decoration: BoxDecoration(
              color: _h
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _h ? AppColors.primaryColor : AppColors.cardBorder,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.expanded
                      ? 'Show Less'
                      : 'Show ${widget.remaining} More Project${widget.remaining == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _h ? AppColors.primaryColor : AppColors.captionColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: widget.expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _h ? AppColors.primaryColor : AppColors.captionColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectData project;
  final int index;
  final double cardWidth;
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.cardWidth,
  });
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
          onEnter: (_) => setState(() => _h = true),
          onExit: (_) => setState(() => _h = false),
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: 220.ms,
            width: widget.cardWidth,
            transform: _h
                ? (Matrix4.identity()..translate(0.0, -8.0))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _h ? AppColors.primaryColor : AppColors.cardBorder,
                width: _h ? 1.5 : 1,
              ),
              boxShadow: _h
                  ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.18),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(_h ? 0.25 : 0.12),
                        AppColors.cardBorder.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(painter: _MiniGridPainter()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.4,
                                  ),
                                ),
                              ),
                              child: Icon(
                                p.icon,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.4,
                                  ),
                                ),
                              ),
                              child: Text(
                                p.category,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _h ? AppColors.primaryColor : AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        p.subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.highlights
                            .map(
                              (h) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryTint,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.primaryColor.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  h,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.tech
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBorder,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.captionColor,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      if (p.playStoreUrl != null ||
                          p.appStoreUrl != null ||
                          p.websiteUrl != null) ...[
                        const SizedBox(height: 14),
                        const Divider(color: AppColors.cardBorder, height: 1),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (p.playStoreUrl != null)
                              _LinkButton(
                                icon: Icons.android_rounded,
                                label: 'Play Store',
                                url: p.playStoreUrl!,
                                color: const Color(0xFF01875F),
                              ),
                            if (p.appStoreUrl != null)
                              _LinkButton(
                                icon: Icons.apple_rounded,
                                label: 'App Store',
                                url: p.appStoreUrl!,
                                color: const Color(0xFF007AFF),
                              ),
                            if (p.websiteUrl != null)
                              _LinkButton(
                                icon: Icons.language_rounded,
                                label: 'Visit Website',
                                url: p.websiteUrl!,
                                color: AppColors.primaryColor,
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 120 * widget.index),
          duration: 500.ms,
        )
        .slideY(begin: 0.2, end: 0);
  }
}

class _LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });
  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          AppToast.info('Opening ${widget.label}…', title: 'Redirecting');
          openUrl(widget.url);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: _h
                ? widget.color.withOpacity(0.15)
                : widget.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _h ? widget.color : widget.color.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 13, color: widget.color),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.open_in_new_rounded,
                size: 10,
                color: widget.color.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.08)
      ..strokeWidth = 0.5;
    const step = 20.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
