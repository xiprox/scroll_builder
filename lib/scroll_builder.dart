library scroll_builder;

import 'dart:math';

import 'package:flutter/widgets.dart';

import 'delegates.dart';
export 'delegates.dart';

class ScrollBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollBuilderDelegate delegate;
  final double breakpoint;
  final Widget? child;

  const ScrollBuilder({
    Key? key,
    required this.scrollController,
    required this.delegate,
    this.child,
    this.breakpoint = 0,
  }) : super(key: key);

  @override
  _ScrollBuilderState createState() => _ScrollBuilderState();
}

class _ScrollBuilderState extends State<ScrollBuilder> {
  double _currentPosition = 0;

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(_setCurrentPosition);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setCurrentPosition);
    super.dispose();
  }

  void _setCurrentPosition() {
    setState(() {
      _currentPosition = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = min(1, _currentPosition / widget.breakpoint).toDouble();
    return widget.delegate.build(
      percentage,
      widget.child ?? const SizedBox.shrink(),
    );
  }
}
