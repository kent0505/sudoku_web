import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../bloc/game_bloc.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({super.key, required this.onLevel});

  final VoidCallback onLevel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state.stopped) return SizedBox(height: 44);

        return Button(
          onPressed: onLevel,
          minSize: 44,
          child: Text(
            state.level.name(context),
            style: TextStyle(
              color: context.colors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}
