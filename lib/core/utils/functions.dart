import 'package:flutter/foundation.dart';
import 'package:personal_portfolio/core/constants/app_assets.dart';
import 'package:personal_portfolio/core/utils/secure_links.dart';
import 'package:personal_portfolio/core/widgets/app_toast.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens any URL in browser / external app.
Future<void> openUrl(String url) async {
  if (url.trim().isEmpty) {
    AppToast.info('Link not configured yet', title: 'Coming Soon');
    return;
  }

  final uri = Uri.tryParse(url.trim());

  if (uri == null) {
    AppToast.error('Invalid URL', title: 'Link Error');
    return;
  }

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('openUrl: cannot launch — $url');
    AppToast.error(
      'Could not open the link. Please try again.',
      title: 'Link Error',
    );
  }
}

/// "Hire Me" — opens the default email client pre-filled.
Future<void> sendHireEmail() async {
  final uri = Uri.parse(SecureLinks.email);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
    AppToast.success('Opening your email app…', title: 'Hire Me');
  } else {
    AppToast.error('Could not open email client.', title: 'Email Error');
  }
}

/// "Download CV" — opens the Google Drive public link.
Future<void> downloadCV() async {
  try {
    final driveUri = Uri.parse(SecureLinks.cv);

    if (await canLaunchUrl(driveUri)) {
      await launchUrl(driveUri, mode: LaunchMode.platformDefault);
      AppToast.success('Opening CV...', title: 'Download');
      return;
    }
  } catch (_) {}

  try {
    final assetUri = Uri.parse(AppAssets.resume);

    await launchUrl(assetUri, mode: LaunchMode.platformDefault);

    AppToast.success('Downloading CV...', title: 'Download');
  } catch (_) {
    AppToast.error('Could not download CV.', title: 'Download Error');
  }
}
