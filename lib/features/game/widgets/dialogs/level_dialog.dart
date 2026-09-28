import 'package:flutter/material.dart';

import '../../../../core/widgets/dialog_widget.dart';
import '../../models/level.dart';
import '../level_tile.dart';

class LevelDialog extends StatelessWidget {
  const LevelDialog({super.key, required this.onPressed});

  final void Function(Level) onPressed;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      spacing: 8,
      children: Level.values.map<Widget>((level) {
        return LevelTile(
          level: level,
          onPressed: onPressed,
        );
      }).toList(),
    );
  }
}
