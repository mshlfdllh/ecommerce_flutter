import 'dart:ui';
import 'package:flutter/material.dart';

/// Reusable warm frosted glassmorphic container inspired by "ordinary." aesthetic.
/// Features backdrop blur, soft ivory/white opacity, warm hairline borders, and subtle drop shadows.
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
  final Color? borderColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 22,
    this.blur = 18,
    this.opacity = 0.82,
    this.color,
    this.padding,
    this.margin,
    this.border,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.gradient,
    this.borderColor,
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
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFF211E1B).withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFFA9442C).withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 2),
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
              borderRadius: shape == BoxShape.circle ? null : effectiveBorderRadius,
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      (color ?? Colors.white).withOpacity((opacity + 0.1).clamp(0.0, 1.0)),
                      (color ?? const Color(0xFFFAF7F2)).withOpacity(opacity),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
              border: border ??
                  Border.all(
                    color: borderColor ?? const Color(0xFFE8E2D8).withOpacity(0.9),
                    width: 1.2,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Warm aesthetic oat-cream liquid background with delicate warm terracotta & sand glow orbs
class LiquidBackground extends StatelessWidget {
  final Widget child;

  const LiquidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F4EE), // Warm oat cream
            Color(0xFFF5F1EA), // Soft linen
            Color(0xFFEDE6DA), // Warm sand
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Ambient Warm Terracotta Glow (Top-Right)
          Positioned(
            top: -90,
            right: -70,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFA9442C).withOpacity(0.08),
                    const Color(0xFFA9442C).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Ambient Warm Sand Arch Glow (Center-Right)
          Positioned(
            top: 180,
            right: -100,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFE2D6C5).withOpacity(0.4),
                    const Color(0xFFE2D6C5).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Ambient Warm Clay Glow (Center-Left)
          Positioned(
            top: 420,
            left: -110,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFEAD8C7).withOpacity(0.35),
                    const Color(0xFFEAD8C7).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Ambient Peach Sand Glow (Bottom-Right)
          Positioned(
            bottom: -80,
            right: -50,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFF2DBC9).withOpacity(0.3),
                    const Color(0xFFF2DBC9).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Main child content
          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}
