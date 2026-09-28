import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.spacing = 0,
    required this.children,
  });

  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spacing,
            children: children,
          ),
        ),
      ),
    );
  }
}
