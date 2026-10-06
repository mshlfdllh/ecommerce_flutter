import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.blur = 18,
    this.opacity = 0.22,
    this.color,
    this.padding,
    this.margin,
    this.border,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = shape == BoxShape.circle
        ? BorderRadius.circular(1000)
        : BorderRadius.circular(borderRadius);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : effectiveBorderRadius,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFF1C514A).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(1000)
            : effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              shape: shape,
              borderRadius: shape == BoxShape.circle
                  ? null
                  : effectiveBorderRadius,
              gradient:
                  gradient ??
                  LinearGradient(
                    colors: [
                      (color ?? const Color(0xFFF8FFFC)).withValues(
                        alpha: opacity + 0.15,
                      ),
                      (color ?? const Color(0xFFE3F4EF)).withValues(
                        alpha: opacity,
                      ),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
              border:
                  border ??
                  Border.all(
                    color: Colors.white.withValues(alpha: 0.62),
                    width: 1.3,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class LiquidBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const LiquidBackground({super.key, required this.child, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF102C2C), Color(0xFF152C35), Color(0xFF282B33)]
              : const [Color(0xFFE7F1ED), Color(0xFFF5F7F1), Color(0xFFE8F0F3)],
        ),
      ),
      child: Stack(
        children: [
          // Broad translucent ribbons keep the backdrop fluid without obscuring content.
          Positioned(
            top: -70,
            left: -90,
            child: Transform.rotate(
              angle: -0.16,
              child: Container(
                width: 560,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF43B9A7)
                          .withValues(alpha: isDark ? 0.2 : 0.2),
                      const Color(0xFF43B9A7).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            right: -260,
            child: Transform.rotate(
              angle: -0.42,
              child: Container(
                width: 620,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF8D75)
                          .withValues(alpha: isDark ? 0.2 : 0.16),
                      const Color(0xFFFF8D75).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -85,
            left: -180,
            child: Transform.rotate(
              angle: 0.18,
              child: Container(
                width: 620,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFB7D66A)
                          .withValues(alpha: isDark ? 0.18 : 0.17),
                      const Color(0xFFB7D66A).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content Layer
          child,
        ],
      ),
    );
  }
}
