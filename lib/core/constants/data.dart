part of 'values.dart';

class SkillData {
  final String skill;
  final int level;
  SkillData({required this.skill, required this.level});
}

class ProjectData {
  final String title;
  final String subtitle;
  final String description;
  final List<String> tech;
  final IconData icon;
  final String category;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? websiteUrl;
  final List<String> highlights;

  const ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tech,
    required this.icon,
    required this.category,
    this.playStoreUrl,
    this.appStoreUrl,
    this.websiteUrl,
    required this.highlights,
  });
}

class ExperienceData {
  final String role;
  final String company;
  final String period;
  final String location;
  final String companyUrl;
  final String type;
  final List<String> points;
  final String? logoAsset;
  const ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.companyUrl,
    required this.type,
    required this.points,
    this.logoAsset,
  });
}

class Data {
  static List<SkillData> skillLevelData = [
    SkillData(skill: 'Flutter & Dart', level: 92),
    SkillData(skill: 'BLoC / Riverpod', level: 88),
    SkillData(skill: 'Clean Architecture', level: 87),
    SkillData(skill: 'REST APIs & Dio', level: 85),
    SkillData(skill: 'Firebase', level: 78),
    SkillData(skill: 'CI/CD & Git', level: 75),
  ];

  static const List<ProjectData> projects = [
    ProjectData(
      title: 'Rise Pro — Alice Blue',
      subtitle: 'Mutual Fund, IPO & NFO Platform',
      description:
          'Led full revamp from Rise to Rise Pro — migrated from Provider/MVVM to BLoC for '
          'improved scalability. Integrated biometric login, FCM push notifications, '
          'CleverTap analytics, and DevRev SDK. Live REST APIs for real-time MF NAV, '
          'IPO, and NFO data.',
      tech: ['Flutter', 'BLoC', 'FCM', 'CleverTap', 'DevRev', 'REST'],
      icon: Icons.trending_up_rounded,
      category: 'Fintech',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.aliceblue.mutualfundapp.ipo',
      appStoreUrl:
          'https://apps.apple.com/in/app/rise-by-alice-blue/id6471658772',
      highlights: ['50,000+ users', 'Biometric Auth', 'Real-time NAV'],
    ),
    ProjectData(
      title: 'Alice Blue eKYC',
      subtitle: 'Digital Demat Account Opening',
      description:
          'End-to-end digital KYC verification platform. Integrated Hyperverge '
          '(face & document verification) and Digio (Aadhaar & PAN e-sign) under '
          'Clean Architecture. Reduced KYC completion time by 60%.',
      tech: ['Flutter', 'Provider', 'Hyperverge', 'Digio', 'Clean Arch'],
      icon: Icons.verified_user_rounded,
      category: 'Fintech',

      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.aliceblue.ekyc',
      appStoreUrl:
          'https://apps.apple.com/in/app/alice-blue-ekyc-demat-app/id6475672771',

      highlights: ['60% faster KYC', 'SEBI/RBI compliant', 'Aadhaar e-sign'],
    ),
    ProjectData(
      title: 'AB Pulse',
      subtitle: 'Partner & Client Management',
      description:
          'Partner referral and client management platform for Alice Blue\'s '
          'business partner network. Secure native-to-web session handoff via '
          'InAppWebView. DigiLink integration for partner onboarding.',
      tech: ['Flutter', 'Riverpod', 'InAppWebView', 'DigiLink'],
      icon: Icons.people_rounded,
      category: 'Fintech',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.aliceblue.partner.dashboard.partner_dashboard_app',
      appStoreUrl: 'https://apps.apple.com/in/app/ab-pulse/id6755806773',
      highlights: ['Partner onboarding', 'Token-based auth', 'DigiLink'],
    ),
    ProjectData(
      title: 'Advisory Application',
      subtitle: 'Trading Signals & Insights',
      description:
          'Subscription-based trading insights platform. Integrated CleverTap '
          'analytics for user engagement and push notifications for real-time '
          'trade alerts. Payment gateway for subscription transactions.',
      tech: ['Flutter', 'Provider', 'CleverTap', 'Payment Gateway', 'REST'],
      icon: Icons.candlestick_chart_rounded,
      category: 'Fintech',
      highlights: ['Real-time alerts', 'Subscription billing', 'Trade signals'],
    ),
    ProjectData(
      title: 'AliceBlue PFM',
      subtitle: 'Personal Finance Management',
      description:
          'Personal finance management platform for mutual fund tracking. '
          'Integrated Setu OneMoney API for aggregated financial data and '
          'Digio for Aadhaar & PAN digital authentication.',
      tech: ['Flutter', 'Provider', 'Setu OneMoney', 'Digio', 'Deep Linking'],
      icon: Icons.account_balance_wallet_rounded,
      category: 'Fintech',
      highlights: ['Setu OneMoney', 'Deep linking', 'MF tracking'],
    ),
    ProjectData(
      title: 'HRMS Payroll System',
      subtitle: 'HR & Payroll Management · ClaySys Technologies',
      description:
          'Built during internship at ClaySys Technologies (USA). Full-featured '
          'HRMS payroll management system using ASP.NET MVC with MySQL — covering '
          'employee management, salary computation, deductions, and payslip generation.',
      tech: ['.NET MVC', 'C#', 'MySQL', 'REST API', 'HTML/CSS'],
      icon: Icons.account_balance_rounded,
      category: '.NET',
      highlights: [
        'Payroll engine',
        'Employee management',
        'Payslip generation',
      ],
    ),
    ProjectData(
      title: 'Senthamizh News',
      subtitle: 'News, Streaming & Short Videos',
      description:
          'Full-featured news app with streaming video, posts, and short-form '
          'video (Shorts). Multi-tab feed covering news, long-form videos, and '
          'short clips with smooth playback and social interaction features.',
      tech: ['Flutter', 'Video Streaming', 'REST API', 'Provider'],
      icon: Icons.play_circle_rounded,
      category: 'Media',
      highlights: ['Video streaming', 'Short videos', 'News feed'],
    ),
  ];

  static const List<ExperienceData> experience = [
    ExperienceData(
      role: 'Flutter Developer',
      company: 'Alice Blue Financial Services Pvt. Ltd.',
      logoAsset: AppAssets.aliceblueLogo,
      period: 'Nov 2023 – Present',
      location: 'Bangalore, India',
      companyUrl: 'https://aliceblueonline.com',
      type: 'full-time',
      points: [
        'Designed and developed 5+ production Flutter apps on Google Play Store serving 50,000+ users',
        'Architected scalable solutions using Clean Architecture & MVVM with BLoC, Provider, Riverpod',
        'Implemented SSL pinning and token-based REST API auth across 4 fintech apps — zero security incidents',
        'Integrated Hyperverge, Digio, CleverTap, DevRev, Setu OneMoney, and payment gateways',
        'Delivered biometric authentication, deep linking, and FCM push notifications',
        'Recognized by senior management for delivering 3 major features 2 weeks ahead of schedule',
        'Collaborated in Agile/Scrum with Git version control and Google Play Console deployments',
      ],
    ),
    ExperienceData(
      role: 'Flutter Developer — Freelance',
      company: 'Plefigos',
      logoAsset: AppAssets.plefigosLogo,
      period: '2023',
      location: 'Remote',
      companyUrl: 'https://plefigos.com/',
      type: 'freelance',
      points: [
        'Built a full-featured news app with streaming video, posts, and short-form video (Shorts)',
        'Implemented smooth video streaming and playback with buffering control and quality selection',
        'Designed a multi-tab feed architecture covering news posts, long-form videos, and short clips',
        'Delivered a polished, responsive UI with engaging animations and social interaction features',
      ],
    ),
    ExperienceData(
      role: '.NET MVC Developer — Intern',
      company: 'ClaySys Technologies',
      logoAsset: AppAssets.claysysLogo,
      period: '3 months · 2023',
      location: 'USA (Remote)',
      companyUrl: 'https://claysys.com',
      type: 'internship',
      points: [
        'Developed an HRMS Payroll Management System using ASP.NET MVC with MySQL database',
        'Built payroll processing modules including salary computation, deductions, and payslip generation',
        'Designed and implemented RESTful APIs for employee and payroll data management',
        'Collaborated with senior engineers at a US-based IT consulting services company',
      ],
    ),
  ];

  static final List<Map<String, dynamic>> techStack = [
    {'label': 'Flutter', 'icon': Icons.phone_android_rounded},
    {'label': 'Dart', 'icon': Icons.code_rounded},
    {'label': 'BLoC', 'icon': Icons.account_tree_rounded},
    {'label': 'Riverpod', 'icon': Icons.hub_rounded},
    {'label': 'Firebase', 'icon': Icons.cloud_rounded},
    {'label': 'REST / Dio', 'icon': Icons.api_rounded},
    {'label': 'SSL Pinning', 'icon': Icons.security_rounded},
    {'label': 'Git / CI·CD', 'icon': Icons.merge_type_rounded},
    {'label': 'CleverTap', 'icon': Icons.analytics_rounded},
    {'label': 'Deep Linking', 'icon': Icons.link_rounded},
    {'label': 'Biometric Auth', 'icon': Icons.fingerprint_rounded},
    {'label': 'FCM', 'icon': Icons.notifications_rounded},
  ];
}
