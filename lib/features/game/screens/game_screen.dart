import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../timer/cubit/timer_cubit.dart';
import '../bloc/game_bloc.dart';
import '../widgets/action_buttons.dart';
import '../widgets/board.dart';
import '../widgets/dialogs/level_dialog.dart';
import '../widgets/info_bar.dart';
import '../widgets/level_button.dart';
import '../widgets/number_buttons.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void onLevel() {
    showDialog(
      context: context,
      builder: (context) {
        return LevelDialog(
          onPressed: (level) {
            context.read<GameBloc>().add(StartGame(level: level));
            context.read<TimerCubit>().start(Duration.zero);
            context.pop();
          },
        );
      },
    );
  }

  void onRestart() async {
    final bloc = context.read<GameBloc>();
    bloc.add(StartGame(
      level: bloc.state.level,
      isWin: bloc.state.isWin,
    ));
    context.read<TimerCubit>().start(Duration.zero);
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
            context.read<GameBloc>().add(StopGame());
          },
        ),
        BlocListener<GameBloc, GameState>(
          listenWhen: (p, c) => c.stopped,
          listener: (context, state) {
            context.read<TimerCubit>().stop();
          },
        ),
        BlocListener<TimerCubit, Duration>(
          listenWhen: (p, c) => c.inSeconds >= GameConfig.maxSeconds,
          listener: (context, state) {
            context.read<GameBloc>().add(StopGame());
          },
        ),
      ],
      child: Scaffold(
        body: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                LevelButton(onLevel: onLevel),
                const InfoBar(),
                const SizedBox(height: 16),
                Board(),
                const SizedBox(height: 16),
                ActionButtons(onRestart: onRestart),
                const SizedBox(height: 16),
                NumberButtons(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
