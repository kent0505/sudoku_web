import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/dialog_widget.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
    required this.title,
    required this.onRestart,
  });

  final String title;
  final VoidCallback onRestart;

  static void show(
    BuildContext context, {
    required String title,
    required VoidCallback onRestart,
  }) {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return GameOverDialog(
          title: title,
          onRestart: onRestart,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return PopScope(
      canPop: false,
      child: DialogWidget(
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text2,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          Button(
            onPressed: onRestart,
            child: Center(
              child: Text(
                'Restart',
                style: TextStyle(
                  color: colors.primary,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
