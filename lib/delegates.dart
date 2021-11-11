import 'package:flutter/widgets.dart';

abstract class ScrollBuilderDelegate {
  Widget build(double progress, Widget child);
}

class ScrollBuilderCustomDelegate extends ScrollBuilderDelegate {
  final Widget Function(double progress, Widget child) builder;

  ScrollBuilderCustomDelegate({required this.builder});

  @override
  Widget build(double progress, Widget child) {
    return builder(progress, child);
  }
}

enum FadeMode { fadeIn, fadeOut }

class ScrollBuilderFadeDelegate extends ScrollBuilderDelegate {
  final FadeMode mode;

  ScrollBuilderFadeDelegate({
    this.mode = FadeMode.fadeOut,
  });

  @override
  Widget build(double progress, Widget child) {
    return Opacity(
      opacity: mode == FadeMode.fadeIn ? progress : 1 - progress,
      child: child,
    );
  }
}
