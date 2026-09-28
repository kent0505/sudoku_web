import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/svg_widget.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.onClear,
    required this.onNote,
    required this.onHint,
  });

  final VoidCallback onClear;
  final VoidCallback onNote;
  final VoidCallback onHint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Button(
          title: 'Clear',
          asset: Assets.clear,
          onPressed: onClear,
        ),
        BlocBuilder<GameBloc, GameState>(
          buildWhen: (p, c) => p.notesMode != c.notesMode,
          builder: (context, state) {
            return _Button(
              title: 'Note',
              data: state.notesMode ? 'ON' : 'OFF',
              active: state.notesMode,
              asset: Assets.note,
              onPressed: onNote,
            );
          },
        ),
        BlocBuilder<GameBloc, GameState>(
          buildWhen: (p, c) => p.hints != c.hints,
          builder: (context, state) {
            return _Button(
              title: 'Hint',
              data: state.hints.toString(),
              active: state.hints >= 1,
              asset: Assets.hint,
              onPressed: onHint,
            );
          },
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    this.data = '',
    this.active = true,
    required this.asset,
    required this.onPressed,
  });

  final String title;
  final String data;
  final bool active;
  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 80,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                Center(
                  child: SvgWidget(
                    asset,
                    height: 32,
                    color: colors.text2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text2,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (data.isNotEmpty)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: active ? colors.primary : colors.text2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: colors.bg,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        data,
                        style: TextStyle(
                          color: colors.bg,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
