import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fade_out_particle/fade_out_particle.dart';

import '../../../core/constants.dart';
import '../bloc/game_bloc.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.onCell});

  final void Function(int index) onCell;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final thinColor = colors.text.withValues(alpha: 0.3);
    final thickColor = colors.text;

    return LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.maxWidth;
        final cellSize = boardSize / 9;

        return SizedBox.square(
          dimension: boardSize,
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Wrap(
                children: List.generate(
                  state.cells.length,
                  (index) {
                    final cell = state.cells[index];

                    final row = index ~/ 9;
                    final col = index % 9;

                    final isSelected = state.index == index;
                    final isSameLine =
                        state.index ~/ 9 == row || state.index % 9 == col;
                    final isSameValue = !state.cells[state.index].cleaned &&
                        state.cells[state.index].value != 0 &&
                        cell.value == state.cells[state.index].value;
                    final isCompleted = state.completedCells.contains(index);

                    return GestureDetector(
                      onTap: () => onCell(index),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: Constants.milliseconds,
                            ),
                            curve: Curves.easeOut,
                            height: cellSize,
                            width: cellSize,
                            decoration: BoxDecoration(
                              color: switch (true) {
                                _ when isCompleted => colors.primary,
                                _ when isSelected =>
                                  colors.tertiary2.withValues(alpha: 0.5),
                                _ when isSameLine =>
                                  colors.tertiary2.withValues(alpha: 0.2),
                                _ when isSameValue =>
                                  colors.tertiary2.withValues(alpha: 0.4),
                                _ => null,
                              },
                              border: Border.all(
                                width: 0.5,
                                color: thinColor,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (cell.value == 0)
                                  FadeOutParticle(
                                    disappear: cell.cleaned,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: List.generate(9, (i) {
                                        return SizedBox(
                                          height: cellSize / 3 - 1,
                                          width: cellSize / 3 - 1,
                                          child: Center(
                                            child: Text(
                                              '${i + 1}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: cell.notes
                                                        .contains(i + 1)
                                                    ? colors.text
                                                        .withValues(alpha: 0.5)
                                                    : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                FadeOutParticle(
                                  disappear: cell.cleaned,
                                  child: Text(
                                    '${cell.value}',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: switch (true) {
                                        _ when isCompleted => colors.bg,
                                        _ when cell.value == 0 =>
                                          Colors.transparent,
                                        _ when cell.opened => colors.text,
                                        _ when cell.value == cell.number =>
                                          colors.primary,
                                        _ => colors.tertiary3,
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // thick borders
                          Container(
                            height: cellSize,
                            width: cellSize,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: row == 0 || row % 3 == 0 ? 2 : 0,
                                  color: row == 0 || row % 3 == 0
                                      ? thickColor
                                      : Colors.transparent,
                                ),
                                left: BorderSide(
                                  width: col == 0 || col % 3 == 0 ? 2 : 0,
                                  color: col == 0 || col % 3 == 0
                                      ? thickColor
                                      : Colors.transparent,
                                ),
                                right: BorderSide(
                                  width: col == 8 ? 2 : 0,
                                  color: col == 8
                                      ? thickColor
                                      : Colors.transparent,
                                ),
                                bottom: BorderSide(
                                  width: row == 8 ? 2 : 0,
                                  color: row == 8
                                      ? thickColor
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
