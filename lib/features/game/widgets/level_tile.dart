import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../models/level.dart';

class LevelTile extends StatelessWidget {
  const LevelTile({
    super.key,
    required this.level,
    required this.onPressed,
  });

  final Level level;
  final void Function(Level) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Button(
      onPressed: () {
        onPressed(level);
      },
      child: Text(
        level.name(context),
        style: TextStyle(
          color: colors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
