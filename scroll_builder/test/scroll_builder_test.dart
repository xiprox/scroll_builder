import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_builder/scroll_builder.dart';

Widget createDummyListWidget() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => ListTile(
        title: Text('Item ${index + 1}'),
      ),
      childCount: 50,
    ),
  );
}

void main() {
  testWidgets('Fraction is the correct value', (tester) async {
    final controller = ScrollController();

    double? lastFractionValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: ScrollBuilder(
                  scrollController: controller,
                  threshold: 100,
                  builder: (context, fraction, child) {
                    lastFractionValue = fraction;
                    return Container();
                  },
                ),
              ),
              createDummyListWidget(),
            ],
          ),
        ),
      ),
    );

    controller.jumpTo(-100);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 0.0);

    controller.jumpTo(0);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 0.0);

    controller.jumpTo(33);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 0.33);

    controller.jumpTo(76);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 0.76);

    controller.jumpTo(100);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 1.0);

    controller.jumpTo(200);
    await tester.pumpAndSettle();
    expect(lastFractionValue, 1.0);
  });

  testWidgets('Passes "child" to "builder"', (tester) async {
    final controller = ScrollController();

    const child = Text('Child');
    Widget? childValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: ScrollBuilder(
                  scrollController: controller,
                  threshold: 100,
                  builder: (context, fraction, child) {
                    childValue = child;
                    return Container();
                  },
                  child: child,
                ),
              ),
              createDummyListWidget(),
            ],
          ),
        ),
      ),
    );

    expect(childValue, child);
  });
}
