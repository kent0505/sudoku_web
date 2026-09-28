import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../timer/cubit/timer_cubit.dart';
import '../bloc/game_bloc.dart';
import '../widgets/action_buttons.dart';
import '../widgets/board.dart';
import '../widgets/dialogs/game_over_dialog.dart';
import '../widgets/dialogs/level_dialog.dart';
import '../widgets/game_appbar.dart';
import '../widgets/info_bar.dart';
import '../widgets/number_buttons.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool gameOver = false;

  void onNumber(int value) {
    context.read<GameBloc>().add(WriteNumber(value: value));
  }

  void onCell(int index) {
    context.read<GameBloc>().add(SelectCell(index: index));
  }

  void onClear() {
    context.read<GameBloc>().add(ClearCell());
  }

  void onNote() {
    context.read<GameBloc>().add(ToggleNotes());
  }

  void onHint() async {
    context.read<GameBloc>().add(UseHint());
  }

  void onLevel() {
    showDialog(
      context: context,
      builder: (context) {
        return LevelDialog(
          onPressed: (level) {
            context.read<GameBloc>().add(NewGame(level: level));
            context.read<TimerCubit>().start(Duration.zero);
            context.pop();
          },
        );
      },
    );
  }

  void showGameOverDialog(OverReason reason) async {
    final bloc = context.read<GameBloc>();
    final timer = context.read<TimerCubit>()..stop();

    GameOverDialog.show(
      context,
      title: switch (reason) {
        OverReason.win => 'Win!',
        OverReason.lose => 'Lose!',
        OverReason.time => 'Time is up!',
      },
      onRestart: () {
        bloc.add(NewGame(
          level: bloc.state.level,
          isWin: reason == OverReason.win,
        ));
        timer.start(Duration.zero);
        context.pop();
        gameOver = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TimerCubit>().start(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GameBloc, GameState>(
          listenWhen: (p, c) => c.isWin || c.isLose,
          listener: (context, state) {
            if (gameOver) return logger('game over');

            gameOver = true;

            showGameOverDialog(
              state.isWin ? OverReason.win : OverReason.lose,
            );
          },
        ),
        BlocListener<TimerCubit, Duration>(
          listenWhen: (p, c) => c.inSeconds >= GameConfig.maxSeconds,
          listener: (context, state) {
            showGameOverDialog(OverReason.time);
          },
        ),
      ],
      child: Scaffold(
        appBar: GameAppbar(onLevel: onLevel),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const InfoBar(),
                  const SizedBox(height: 10),
                  Board(onCell: onCell),
                  const SizedBox(height: 16),
                  ActionButtons(
                    onClear: onClear,
                    onNote: onNote,
                    onHint: onHint,
                  ),
                  const SizedBox(height: 16),
                  NumberButtons(onNumber: onNumber),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
