import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scroll_builder/scroll_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    const collapsedHeight = 56.0;
    const expandedHeight = 200.0;
    const scrollAmountUntilCollapsed = expandedHeight - collapsedHeight;
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              collapsedHeight: collapsedHeight,
              expandedHeight: expandedHeight,
              titleSpacing: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.0,
                title: ScrollBuilder(
                  scrollController: controller,
                  threshold: scrollAmountUntilCollapsed,
                  builder: (context, fraction, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        -24 * Curves.easeOutCubic.transform(1 - fraction),
                      ),
                      child: Transform.rotate(
                        angle: pi * 4 * Curves.easeInOut.transform(fraction),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: fraction != 0 && fraction != 1 ? 0.5 : 0,
                            sigmaY: fraction != 0 && fraction != 1 ? 0.5 : 0,
                          ),
                          child: Text(
                            'News',
                            style: TextStyle(
                              fontSize: Tween<double>(
                                begin: 18,
                                end: 56,
                              ).transform(1 - fraction),
                              fontWeight: FontWeight.lerp(
                                FontWeight.w200,
                                FontWeight.w500,
                                fraction,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item ${index + 1}'),
                ),
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
