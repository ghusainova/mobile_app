import 'package:flutter/material.dart';

class AnimatedStatusIcon extends StatefulWidget {
  final IconData iconData;
  final Color color;
  final double size;
  final Duration duration;

  const AnimatedStatusIcon({
    required this.iconData,
    required this.color,
    required this.size,
    this.duration = const Duration(milliseconds: 800),
    super.key,
  });

  @override
  State<AnimatedStatusIcon> createState() => _AnimatedStatusIconState();
}

class _AnimatedStatusIconState extends State<AnimatedStatusIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animationController);

    _playAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Icon(
        widget.iconData,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
