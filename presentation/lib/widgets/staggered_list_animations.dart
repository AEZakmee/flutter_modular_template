import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredListView extends StatelessWidget {
  const StaggeredListView({required this.children, super.key});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder:
              (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
          children: children,
        ),
      ),
    );
  }
}

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({
    required this.count,
    required this.child,
    super.key,
  });

  final int count;
  final Function(int) child;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(count, (int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: count ~/ 2,
            child: ScaleAnimation(child: FadeInAnimation(child: child(index))),
          );
        }),
      ),
    );
  }
}

class StaggeredColumn extends StatelessWidget {
  const StaggeredColumn({required this.children, super.key});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder:
              (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
          children: children,
        ),
      ),
    );
  }
}

class StaggeredRow extends StatelessWidget {
  const StaggeredRow({required this.children, super.key});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Row(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder:
              (widget) => ScaleAnimation(child: FadeInAnimation(child: widget)),
          children: children,
        ),
      ),
    );
  }
}
