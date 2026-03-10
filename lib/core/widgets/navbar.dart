import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/app_config.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  const Navbar({super.key, required this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;

  double _lastOffset = 0;
  bool _visible = true;
  static const double _hideThreshold = 8;
  static const double _atTopThreshold = 10;

  @override
  void initState() {
    super.initState();

    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..value = 1;

    _slideAnim = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _slideCtrl,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        );

    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;
    final delta = offset - _lastOffset;

    if (offset <= _atTopThreshold) {
      _show();
      _lastOffset = offset;
      return;
    }

    if (delta > _hideThreshold && _visible) {
      _hide();
    } else if (delta < -_hideThreshold && !_visible) {
      _show();
    }

    _lastOffset = offset;
  }

  void _show() {
    if (!_visible) setState(() => _visible = true);
    _slideCtrl.forward();
  }

  void _hide() {
    if (_visible) setState(() => _visible = false);
    _slideCtrl.reverse();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isCompact = screenW < 700;
    final topInset = MediaQuery.of(context).padding.top;

    return SlideTransition(
      position: _slideAnim,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: EdgeInsets.only(
              left: isCompact ? 20 : 40,
              right: isCompact ? 20 : 40,
              top: topInset + 14,
              bottom: 14,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.72),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.cardBorder.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => scrollToKey(heroKey),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '<',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 22,
                              ),
                        ),
                        TextSpan(
                          text: StringConst.NAME_ABBREV,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: AppColors.white, fontSize: 22),
                        ),
                        TextSpan(
                          text: '/>',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 22,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (!isCompact)
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavItem(title: StringConst.ABOUT, scrollKey: aboutKey),
                        _NavItem(
                          title: StringConst.SKILLS,
                          scrollKey: skillsKey,
                        ),
                        _NavItem(
                          title: StringConst.PROJECTS,
                          scrollKey: projectsKey,
                        ),
                        _NavItem(
                          title: StringConst.CONTACT,
                          scrollKey: contactKey,
                        ),
                      ],
                    ),
                  )
                else
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                      onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.3, end: 0);
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final GlobalKey scrollKey;
  const _NavItem({required this.title, required this.scrollKey});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => scrollToKey(widget.scrollKey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: 200.ms,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: _hovered
                      ? AppColors.primaryColor
                      : AppColors.captionColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: 200.ms,
                height: 2,
                width: _hovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '<',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBM Plex Mono',
                    ),
                  ),
                  TextSpan(
                    text: StringConst.NAME_ABBREV,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBM Plex Mono',
                    ),
                  ),
                  TextSpan(
                    text: '/>',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBM Plex Mono',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _DrawerItem(title: StringConst.ABOUT, scrollKey: aboutKey),
            _DrawerItem(title: StringConst.SKILLS, scrollKey: skillsKey),
            _DrawerItem(title: StringConst.PROJECTS, scrollKey: projectsKey),
            _DrawerItem(title: StringConst.CONTACT, scrollKey: contactKey),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final GlobalKey scrollKey;
  const _DrawerItem({required this.title, required this.scrollKey});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Container(
        width: 4,
        height: 20,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Future.delayed(300.ms, () => scrollToKey(scrollKey));
      },
    );
  }
}
