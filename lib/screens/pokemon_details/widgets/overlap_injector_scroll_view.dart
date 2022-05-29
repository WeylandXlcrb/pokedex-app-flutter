import 'package:flutter/material.dart';

const _edgePadding = SliverToBoxAdapter(child: SizedBox(height: 32.0));

class OverlapInjectorScrollView extends StatelessWidget {
  final List<Widget> slivers;

  const OverlapInjectorScrollView({
    Key? key,
    required this.slivers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Required to not allow body scroll under sliver header
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        _edgePadding,
        ...slivers,
        _edgePadding,
      ],
    );
  }
}
