import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  AppToast._();

  static const Duration _short = Duration(milliseconds: 2500);
  static const Duration _normal = Duration(milliseconds: 3500);
  static const Duration _long = Duration(milliseconds: 5000);

  static void success(String message, {String? title, Duration? duration}) =>
      _show(
        message: message,
        title: title ?? 'Success',
        icon: Icons.check_circle_rounded,
        accent: AppColors.primaryColor,
        duration: duration ?? _short,
      );

  static void error(String message, {String? title, Duration? duration}) =>
      _show(
        message: message,
        title: title ?? 'Error',
        icon: Icons.error_rounded,
        accent: AppColors.dangerColor,
        duration: duration ?? _long,
      );

  static void warning(String message, {String? title, Duration? duration}) =>
      _show(
        message: message,
        title: title ?? 'Warning',
        icon: Icons.warning_amber_rounded,
        accent: const Color(0xFFF5A623),
        duration: duration ?? _normal,
      );

  static void info(String message, {String? title, Duration? duration}) =>
      _show(
        message: message,
        title: title ?? 'Info',
        icon: Icons.info_rounded,
        accent: const Color(0xFF4DA6FF),
        duration: duration ?? _normal,
      );

  static void dismissAll() => toastification.dismissAll();

  static void _show({
    required String message,
    required String title,
    required IconData icon,
    required Color accent,
    required Duration duration,
  }) {
    toastification.showCustom(
      autoCloseDuration: duration,
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 380),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0, -1.2),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      builder: (context, holder) {
        return _ToastCard(
          holder: holder,
          title: title,
          message: message,
          icon: icon,
          accent: accent,
          duration: duration,
        );
      },
    );
  }
}

class _ToastCard extends StatefulWidget {
  final ToastificationItem holder;
  final String title, message;
  final IconData icon;
  final Color accent;
  final Duration duration;

  const _ToastCard({
    required this.holder,
    required this.title,
    required this.message,
    required this.icon,
    required this.accent,
    required this.duration,
  });

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..forward();
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.accent.withOpacity(0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: widget.accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: widget.accent.withOpacity(0.3),
                        ),
                      ),
                      child: Icon(widget.icon, color: widget.accent, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.ibmPlexMono(
                              color: AppColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.message,
                            style: GoogleFonts.lato(
                              color: AppColors.captionColor,
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toastification.dismiss(widget.holder),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.captionColor.withOpacity(0.5),
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _progressCtrl,
                builder: (_, __) => LinearProgressIndicator(
                  value: 1.0 - _progressCtrl.value,
                  minHeight: 2.5,
                  backgroundColor: AppColors.cardBorder,
                  valueColor: AlwaysStoppedAnimation(
                    widget.accent.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
