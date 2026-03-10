import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum SectionAnimation { fade, slideUp, slideLeft, slideRight, scale }

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final SectionAnimation animation;

  const AnimatedSection({
    super.key,
    required this.child,
    this.animation = SectionAnimation.slideUp,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child;

    switch (widget.animation) {
      case SectionAnimation.fade:
        animatedChild = animatedChild.animate(target: visible ? 1 : 0).fadeIn();
        break;

      case SectionAnimation.slideUp:
        animatedChild = animatedChild
            .animate(target: visible ? 1 : 0)
            .fadeIn()
            .slideY(begin: 0.2);
        break;

      case SectionAnimation.slideLeft:
        animatedChild = animatedChild
            .animate(target: visible ? 1 : 0)
            .fadeIn()
            .slideX(begin: -0.2);
        break;

      case SectionAnimation.slideRight:
        animatedChild = animatedChild
            .animate(target: visible ? 1 : 0)
            .fadeIn()
            .slideX(begin: 0.2);
        break;

      case SectionAnimation.scale:
        animatedChild = animatedChild
            .animate(target: visible ? 1 : 0)
            .fadeIn()
            .scale(begin: const Offset(0.9, 0.9));
        break;
    }

    return VisibilityDetector(
      key: Key(widget.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !visible) {
          setState(() => visible = true);
        }
      },
      child: animatedChild,
    );
  }
}
