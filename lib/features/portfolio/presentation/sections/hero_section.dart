import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/core/utils/functions.dart';
import 'package:personal_portfolio/core/constants/app_assets.dart';
import 'package:personal_portfolio/core/utils/secure_links.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final compact = sw < 700;
    final showCard = sw >= 900;

    if (compact) {
      return ColoredBox(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 72),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeroContent(compact: true),
                const SizedBox(height: 40),
                _ProfileCard(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: sh * 0.90,
      child: Stack(
        children: [
          const Positioned.fill(child: _GridBackground()),
          Positioned(
            top: sh * 0.1,
            right: sw * 0.1,
            child: _GlowOrb(
              size: 300,
              color: AppColors.primaryColor.withOpacity(0.06),
            ),
          ),
          Positioned(
            bottom: sh * 0.1,
            left: sw * 0.05,
            child: _GlowOrb(
              size: 200,
              color: AppColors.primaryColor.withOpacity(0.04),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sw < 900 ? 32 : 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _HeroContent(compact: false)),
                if (showCard) ...[
                  const SizedBox(width: 48),
                  SizedBox(width: 320, child: _ProfileCard()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridBackground extends StatelessWidget {
  const _GridBackground();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cardBorder.withOpacity(0.35)
      ..strokeWidth = 0.5;
    const step = 48.0;
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

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;
  const _GlowOrb({required this.size, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [color, Colors.transparent]),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1.1, 1.1),
          duration: 4000.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _HeroContent extends StatelessWidget {
  final bool compact;
  const _HeroContent({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusPill()
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideX(begin: -0.2, end: 0),

        SizedBox(height: compact ? 16 : 22),

        Text(
          StringConst.FIRST_NAME,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: compact ? 36 : 58,
            height: 1.1,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 4),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '> ',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primaryColor,
                fontSize: compact ? 18 : 26,
              ),
            ),
            Flexible(
              child: AnimatedTextKit(
                repeatForever: true,
                pause: 800.ms,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Flutter Developer',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(
                          color: AppColors.white,
                          fontSize: compact ? 18 : 26,
                        ),
                    speed: 60.ms,
                  ),
                  TypewriterAnimatedText(
                    'Fintech App Builder',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(
                          color: AppColors.white,
                          fontSize: compact ? 18 : 26,
                        ),
                    speed: 60.ms,
                  ),
                  TypewriterAnimatedText(
                    'Clean Arch Advocate',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(
                          color: AppColors.white,
                          fontSize: compact ? 18 : 26,
                        ),
                    speed: 60.ms,
                  ),
                  TypewriterAnimatedText(
                    'Mobile UI Craftsman',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(
                          color: AppColors.white,
                          fontSize: compact ? 18 : 26,
                        ),
                    speed: 60.ms,
                  ),
                  TypewriterAnimatedText(
                    'BLoC · Riverpod · MVVM',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(
                          color: AppColors.white,
                          fontSize: compact ? 18 : 26,
                        ),
                    speed: 60.ms,
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(delay: 320.ms),

        SizedBox(height: compact ? 16 : 22),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 14,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              StringConst.LOCATION,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.captionColor),
            ),
          ],
        ).animate().fadeIn(delay: 380.ms),

        const SizedBox(height: 18),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            StringConst.ABOUT_DEV,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
          ),
        ).animate().fadeIn(delay: 440.ms),

        const SizedBox(height: 20),

        _StatsRow().animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 32),

        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: const [
            _PrimaryBtn(
              label: StringConst.HIRE_ME_NOW,
              icon: Icons.rocket_launch_rounded,
            ),
            _OutlineBtn(
              label: StringConst.DOWNLOAD_CV,
              icon: Icons.download_rounded,
            ),
          ],
        ).animate().fadeIn(delay: 560.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 16),
        _HeroSocialRow()
            .animate()
            .fadeIn(delay: 650.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }
}

class _HeroSocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _SocialBtn(
          icon: Image.asset(AppAssets.gmailIcon, height: 16),
          label: 'Gmail',
          url: SecureLinks.email,
        ),
        _SocialBtn(
          icon: Image.asset(
            AppAssets.githubIcon,
            height: 16,
            color: Colors.white,
          ),
          label: 'GitHub',
          url: SecureLinks.github,
        ),
        _SocialBtn(
          icon: Image.asset(AppAssets.linkedinIcon, height: 16),
          label: 'LinkedIn',
          url: SecureLinks.linkedin,
        ),
        _SocialBtn(
          icon: Image.asset(AppAssets.stackoverflowIcon, height: 16),
          label: 'Stack Overflow',
          url: SecureLinks.stackoverflow,
        ),
      ],
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final Widget icon;
  final String label, url;
  const _SocialBtn({
    required this.icon,
    required this.label,
    required this.url,
  });
  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: _h ? AppColors.primaryTint : AppColors.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _h ? AppColors.primaryColor : AppColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon,
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _h ? AppColors.primaryColor : AppColors.captionColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingDot(),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              StringConst.INTRO,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: 1200.ms)
      ..repeat(reverse: true);
    _a = Tween<double>(begin: 0.4, end: 1.0).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _a,
    builder: (_, __) => Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withOpacity(_a.value),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(_a.value * 0.6),
            blurRadius: 6,
          ),
        ],
      ),
    ),
  );
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      children: const [
        _Stat(value: '2+', label: 'Years Exp'),
        _Stat(value: '5+', label: 'Apps Shipped'),
        _Stat(value: '50K+', label: 'Active Users'),
        _Stat(value: '0', label: 'Security Incidents'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.primaryColor,
            fontSize: 22,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.captionColor,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.cardBorder),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primary300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.4),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            SecureLinks.avatar,
                            fit: BoxFit.cover,
                            width: 110,
                            height: 110,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppAssets.profilePhoto,
                                fit: BoxFit.cover,
                                width: 110,
                                height: 110,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Abhijith P',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Flutter Developer',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bangalore, India',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppColors.cardBorder),
                  const SizedBox(height: 14),
                  _InfoRow(
                    icon: Icons.business_center_rounded,
                    text: 'Alice Blue Financial',
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.school_rounded,
                    text: 'MCA · Kannur University',
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.verified_rounded,
                    text: '5+ Production Apps',
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: 300.ms, duration: 600.ms)
            .slideX(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _AchievementChip(
                icon: Icons.security_rounded,
                label: 'Zero Security\nIncidents',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AchievementChip(
                icon: Icons.speed_rounded,
                label: '60% Faster\nKYC Flow',
              ),
            ),
          ],
        ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.3, end: 0),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primaryColor),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _AchievementChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AchievementChip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryColor,
                fontSize: 10,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  const _PrimaryBtn({required this.label, required this.icon});
  @override
  State<_PrimaryBtn> createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<_PrimaryBtn> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 200.ms,
        decoration: BoxDecoration(
          color: _h ? AppColors.primary200 : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _h
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: TextButton.icon(
          onPressed: () => sendHireEmail(),
          icon: Icon(widget.icon, size: 16, color: Colors.white),
          label: Text(widget.label),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  const _OutlineBtn({required this.label, required this.icon});
  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 200.ms,
        decoration: BoxDecoration(
          color: _h ? AppColors.primaryTint : Colors.transparent,
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton.icon(
          onPressed: () => downloadCV(),
          icon: Icon(widget.icon, size: 16, color: AppColors.primaryColor),
          label: Text(widget.label),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
    );
  }
}
