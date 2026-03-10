import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/core/widgets/animated_section.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/navbar.dart';
import 'features/portfolio/presentation/sections/about_section.dart';
import 'features/portfolio/presentation/sections/contact_section.dart';
import 'features/portfolio/presentation/sections/hero_section.dart';
import 'features/portfolio/presentation/sections/projects_section.dart';
import 'features/portfolio/presentation/sections/skills_section.dart';
import 'features/onboarding/presentation/splash_screen.dart';

final GlobalKey heroKey = GlobalKey();
final GlobalKey aboutKey = GlobalKey();
final GlobalKey skillsKey = GlobalKey();
final GlobalKey projectsKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

void scrollToKey(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx != null) {
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: "Personal Portfolio (Abhijith P)",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 600, name: MOBILE),
            Breakpoint(start: 601, end: 900, name: TABLET),
            Breakpoint(start: 901, end: 1400, name: DESKTOP),
            Breakpoint(start: 1401, end: double.infinity, name: '4K'),
          ],
        ),
        home: const RootPage(),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late bool _showSplash = !kIsWeb;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomePage(),
        if (_showSplash)
          SplashScreen(onComplete: () => setState(() => _showSplash = false)),
      ],
    );
  }
}

const double kNavbarHeight = 64.0;

double navbarTotalHeight(BuildContext context) =>
    kNavbarHeight + MediaQuery.of(context).padding.top;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final topPadding = navbarTotalHeight(context) + 8;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      endDrawer: isMobile ? const MobileDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: topPadding),
            child: Column(
              children: [
                HeroSection(key: heroKey),

                AnimatedSection(
                  animation: SectionAnimation.slideUp,
                  child: AboutSection(key: aboutKey),
                ),

                AnimatedSection(
                  animation: SectionAnimation.slideLeft,
                  child: SkillsSection(key: skillsKey),
                ),

                AnimatedSection(
                  animation: SectionAnimation.scale,
                  child: ProjectsSection(key: projectsKey),
                ),

                AnimatedSection(
                  animation: SectionAnimation.slideRight,
                  child: ContactSection(key: contactKey),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              key: UniqueKey(),
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
