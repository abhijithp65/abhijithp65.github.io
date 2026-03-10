import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/core/utils/secure_links.dart';
import 'package:personal_portfolio/core/widgets/app_toast.dart';
import 'package:personal_portfolio/core/utils/functions.dart';
import 'package:personal_portfolio/core/constants/app_assets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final compact = sw < 700;
    final px = compact ? 20.0 : (sw < 900 ? 40.0 : 80.0);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: ColoredBox(
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
                    'CONTACT',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringConst.LETS_TALK,
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
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      'Have a project in mind or want to discuss a role? I\'d love to hear from you.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),

              const SizedBox(height: 52),

              Container(
                constraints: const BoxConstraints(maxWidth: 780),
                padding: EdgeInsets.all(compact ? 24 : 48),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.07),
                      blurRadius: 60,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: compact
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ContactInfo(),
                          const SizedBox(height: 36),
                          _ContactForm(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: _ContactInfo()),
                          const SizedBox(width: 48),
                          Expanded(flex: 5, child: _ContactForm()),
                        ],
                      ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 48),
              Text(
                StringConst.RIGHTS_RESERVED,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.captionColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Get in Touch', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text(
          'Open to full-time roles, freelance projects, and collaborations.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
        const SizedBox(height: 28),

        _ContactRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: StringConst.DEV_EMAIL,
          onTap: () => openUrl(SecureLinks.email),
        ),
        const SizedBox(height: 14),
        _ContactRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'Bangalore, India',
        ),

        const SizedBox(height: 28),

        Text(
          'Find me on',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.captionColor,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
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
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final VoidCallback? onTap;
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primaryTint,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 18),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.captionColor,
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: onTap != null
                      ? AppColors.primaryColor
                      : AppColors.white,
                  fontWeight: FontWeight.w600,
                  decoration: onTap != null ? TextDecoration.underline : null,
                  decorationColor: AppColors.primaryColor.withOpacity(0.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: content),
      );
    }
    return content;
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
            color: _h ? AppColors.primaryTint : AppColors.backgroundColor,
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

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  final _nameErr = ValueNotifier<String?>(null);
  final _emailErr = ValueNotifier<String?>(null);
  final _subjectErr = ValueNotifier<String?>(null);
  final _msgErr = ValueNotifier<String?>(null);

  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    _nameErr.dispose();
    _emailErr.dispose();
    _subjectErr.dispose();
    _msgErr.dispose();
    super.dispose();
  }

  bool _validate() {
    bool ok = true;

    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      _nameErr.value = 'Name is required';
      ok = false;
    } else if (name.length < 2) {
      _nameErr.value = 'Name is too short';
      ok = false;
    } else {
      _nameErr.value = null;
    }

    final email = _emailCtrl.text.trim();
    final emailReg = RegExp(
      r'^[\w\.\+\-]+@[\w\-]+\.[a-z]{2,}$',
      caseSensitive: false,
    );
    if (email.isEmpty) {
      _emailErr.value = 'Email is required';
      ok = false;
    } else if (!emailReg.hasMatch(email)) {
      _emailErr.value = 'Enter a valid email address';
      ok = false;
    } else {
      _emailErr.value = null;
    }

    final subject = _subjectCtrl.text.trim();
    if (subject.isEmpty) {
      _subjectErr.value = 'Subject is required';
      ok = false;
    } else {
      _subjectErr.value = null;
    }

    final msg = _msgCtrl.text.trim();
    if (msg.isEmpty) {
      _msgErr.value = 'Message is required';
      ok = false;
    } else if (msg.length < 10) {
      _msgErr.value = 'Message is too short (min 10 chars)';
      ok = false;
    } else {
      _msgErr.value = null;
    }

    return ok;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_validate()) {
      AppToast.warning(
        'Please fill in all required fields correctly.',
        title: 'Incomplete Form',
      );
      return;
    }
    sendHireEmail();
    setState(() => _sent = true);
    AppToast.success(
      'Message sent! I\'ll get back to you soon.',
      title: 'Message Sent',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.primaryTint,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.4)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primaryColor,
              size: 52,
            ),
            const SizedBox(height: 16),
            Text(
              'Message Sent!',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Thanks for reaching out. I'll get back to you soon.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => setState(() {
                _sent = false;
                _nameCtrl.clear();
                _emailCtrl.clear();
                _subjectCtrl.clear();
                _msgCtrl.clear();
              }),
              child: Text(
                'Send another message',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ).animate().scale(begin: const Offset(0.85, 0.85)).fadeIn();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ValidatedField(
          label: 'Your Name',
          hint: 'John Doe',
          controller: _nameCtrl,
          error: _nameErr,
          textInputAction: TextInputAction.next,
          onChanged: (_) {
            if (_nameErr.value != null) _validate();
          },
        ),
        const SizedBox(height: 14),
        _ValidatedField(
          label: 'Email Address',
          hint: 'john@example.com',
          controller: _emailCtrl,
          error: _emailErr,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (_) {
            if (_emailErr.value != null) _validate();
          },
        ),
        const SizedBox(height: 14),
        _ValidatedField(
          label: 'Subject',
          hint: 'Flutter Developer Role / Project',
          controller: _subjectCtrl,
          error: _subjectErr,
          textInputAction: TextInputAction.next,
          onChanged: (_) {
            if (_subjectErr.value != null) _validate();
          },
        ),
        const SizedBox(height: 14),
        _ValidatedField(
          label: 'Message',
          hint: 'Tell me about the project or role...',
          controller: _msgCtrl,
          error: _msgErr,
          maxLines: 4,
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            if (_msgErr.value != null) _validate();
          },
        ),
        const SizedBox(height: 20),
        _SendButton(onTap: _submit),
      ],
    );
  }
}

class _ValidatedField extends StatefulWidget {
  final String label, hint;
  final TextEditingController controller;
  final ValueNotifier<String?> error;
  final int maxLines;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;

  const _ValidatedField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.error,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  });
  @override
  State<_ValidatedField> createState() => _ValidatedFieldState();
}

class _ValidatedFieldState extends State<_ValidatedField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.error,
      builder: (_, err, __) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: err != null
                  ? AppColors.dangerColor
                  : AppColors.captionColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.textInputAction == TextInputAction.done
                ? (_) => FocusScope.of(context).unfocus()
                : null,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.white),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.captionColor.withOpacity(0.45),
              ),
              filled: true,
              fillColor: AppColors.backgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: err != null
                      ? AppColors.dangerColor.withOpacity(0.6)
                      : AppColors.cardBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: err != null
                      ? AppColors.dangerColor
                      : AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.dangerColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: 180.ms,
            child: err != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 12,
                          color: AppColors.dangerColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          err,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.dangerColor,
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SendButton({required this.onTap});
  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 200.ms,
        width: double.infinity,
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
          onPressed: widget.onTap,
          icon: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
          label: const Text('Send Message'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
