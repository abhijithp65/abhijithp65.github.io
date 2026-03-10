import 'dart:math';
import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/constants/values.dart';
import 'package:personal_portfolio/features/onboarding/widgets/logo_text.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleCtrl;
  late AnimationController _logoCtrl;
  late AnimationController _holdCtrl;
  late AnimationController _exitCtrl;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _glowRadius;
  late Animation<double> _particleOpacity;
  late Animation<double> _exitOpacity;

  final List<_Particle> _particles = [];
  final Random _rng = Random();

  static const int _tParticle = 1400;
  static const int _tLogo = 700;
  static const int _tHold = 600;
  static const int _tExit = 500;

  @override
  void initState() {
    super.initState();

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _tParticle),
    );

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _tLogo),
    );

    _holdCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _tHold),
    );

    _exitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _tExit),
    );

    _logoScale = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _glowRadius = Tween<double>(
      begin: 0,
      end: 80,
    ).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut));

    _particleOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _exitOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _exitCtrl, curve: Curves.easeInOut));

    _spawnParticles();
    _runSequence();
  }

  void _spawnParticles() {
    for (int i = 0; i < 70; i++) {
      final angle = _rng.nextDouble() * 2 * pi;
      final radius = 100.0 + _rng.nextDouble() * 280.0;
      final isGreen = _rng.nextDouble() > 0.25;
      _particles.add(
        _Particle(
          startX: cos(angle) * radius,
          startY: sin(angle) * radius,
          size: 1.5 + _rng.nextDouble() * 4.5,
          delay: _rng.nextDouble() * 0.35,
          color: isGreen
              ? AppColors.primaryColor.withOpacity(
                  0.5 + _rng.nextDouble() * 0.5,
                )
              : AppColors.white.withOpacity(0.15 + _rng.nextDouble() * 0.25),
        ),
      );
    }
  }

  Future<void> _runSequence() async {
    await _particleCtrl.forward();

    await _logoCtrl.forward();

    await _holdCtrl.forward();

    await _exitCtrl.forward();

    widget.onComplete();
  }

  @override
  void dispose() {
    _particleCtrl.dispose();
    _logoCtrl.dispose();
    _holdCtrl.dispose();
    _exitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cx = size.width / 2;
    final cy = size.height / 2;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _particleCtrl,
        _logoCtrl,
        _holdCtrl,
        _exitCtrl,
      ]),
      builder: (_, __) {
        return Opacity(
          opacity: _exitOpacity.value,
          child: ColoredBox(
            color: AppColors.backgroundColor,
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(
                        opacity: (1.0 - _exitCtrl.value) * 0.3,
                      ),
                    ),
                  ),

                  ..._particles.map((p) {
                    final t = (_particleCtrl.value - p.delay).clamp(0.0, 1.0);
                    final eased = Curves.easeInOutCubic.transform(t);
                    final x = cx + p.startX * (1.0 - eased);
                    final y = cy + p.startY * (1.0 - eased);

                    final particleFade = _logoCtrl.value > 0
                        ? _particleOpacity.value
                        : (t < 0.08 ? t / 0.08 : 1.0);

                    return Positioned(
                      left: x - p.size / 2,
                      top: y - p.size / 2,
                      child: Opacity(
                        opacity: particleFade.clamp(0.0, 1.0),
                        child: Container(
                          width: p.size,
                          height: p.size,
                          decoration: BoxDecoration(
                            color: p.color,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                blurRadius: p.size * 2.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  if (_logoCtrl.value > 0)
                    Positioned(
                      left: cx - _glowRadius.value * 2.5,
                      top: cy - _glowRadius.value * 2.5,
                      child: Opacity(
                        opacity: (_logoOpacity.value * 0.4).clamp(0.0, 1.0),
                        child: Container(
                          width: _glowRadius.value * 5,
                          height: _glowRadius.value * 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.45),
                                AppColors.primaryColor.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (_logoCtrl.value > 0)
                    Positioned(
                      left: cx - _glowRadius.value,
                      top: cy - _glowRadius.value,
                      child: Opacity(
                        opacity: (_logoOpacity.value * 0.25).clamp(0.0, 1.0),
                        child: Container(
                          width: _glowRadius.value * 2,
                          height: _glowRadius.value * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.8),
                                AppColors.primaryColor.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  Center(
                    child: Opacity(
                      opacity: _logoOpacity.value.clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: const LogoText(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  final double opacity;
  const _GridPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cardBorder.withOpacity(opacity)
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
  bool shouldRepaint(_GridPainter old) => old.opacity != opacity;
}

class _Particle {
  final double startX, startY, size, delay;
  final Color color;
  const _Particle({
    required this.startX,
    required this.startY,
    required this.size,
    required this.delay,
    required this.color,
  });
}
