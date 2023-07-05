library scroll_builder;

import 'package:flutter/widgets.dart';

class ScrollBuilder extends StatelessWidget {
  final ScrollController scrollController;

  /// The scroll offset at which the builder will be called with a fraction of
  /// 1.0.
  final double threshold;

  /// A builder that is called whenever the scroll offset changes.
  ///
  /// [fraction] is a [double] between 0.0 and 1.0 that represents how much of
  /// the scrolling towards the [threshold] has been done. For example, if
  /// [threshold] is given as `100.0` and the current scroll offset is `25.0`,
  /// [fraction] will be `0.25`.
  final Widget Function(
    BuildContext context,
    double fraction,
    Widget? child,
  ) builder;

  final Widget? child;

  const ScrollBuilder({
    Key? key,
    required this.scrollController,
    required this.threshold,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final offset = scrollController.offset;
        final fraction = (offset / threshold).clamp(0.0, 1.0);
        return builder(
          context,
          fraction,
          child ?? const SizedBox.shrink(),
        );
      },
      child: child,
    );
  }
}
