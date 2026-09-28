import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';

class NumberButtons extends StatelessWidget {
  const NumberButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: List.generate(9, (index) {
          final number = index + 1;

          return SizedBox(
            width: constraints.maxWidth / 9 - 2,
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                final amount = state.cells
                    .where((c) => c.value == number && c.value == c.number)
                    .length;

                if (amount == 9 || state.stopped) {
                  return const SizedBox(height: 44);
                }

                return Button(
                  onPressed: () {
                    context.read<GameBloc>().add(WriteNumber(value: number));
                  },
                  minSize: 44,
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 34,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
