import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../timer/cubit/timer_cubit.dart';
import '../bloc/game_bloc.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        BlocBuilder<TimerCubit, Duration>(
          builder: (context, state) {
            return _Info(
              title: 'Time:',
              value: formatTimer(state),
            );
          },
        ),
        const Spacer(),
        BlocBuilder<GameBloc, GameState>(
          buildWhen: (p, c) => p.mistakes != c.mistakes,
          builder: (context, state) {
            return _Info(
              title: 'Mistakes',
              value: '${state.mistakes}/${GameConfig.maxMistakes}',
            );
          },
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: 80,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.text2,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: colors.text2,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
