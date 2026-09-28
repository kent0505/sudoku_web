import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../bloc/game_bloc.dart';

class GameAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppbar({super.key, required this.onLevel});

  final VoidCallback onLevel;

  final height = 60.0;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: height + context.top,
      padding: EdgeInsets.only(
        top: context.top,
        left: 8,
        right: 8,
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Center(
              child: Button(
                onPressed: onLevel,
                child: BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    return Text(
                      state.level.name(context),
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
