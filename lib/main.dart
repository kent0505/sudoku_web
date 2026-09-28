import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants.dart';
import 'core/themes.dart';
import 'features/game/bloc/game_bloc.dart';
import 'features/game/data/game_repository.dart';
import 'features/game/models/level.dart';
import 'features/game/screens/game_screen.dart';
import 'features/timer/cubit/timer_cubit.dart';

// adb tcpip 5555 && adb connect 192.168.0.190

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GameRepository>(
          create: (context) => GameRepositoryImpl(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GameBloc(
              repository: context.read<GameRepository>(),
            )..add(NewGame(level: Level.noob)),
          ),
          BlocProvider(create: (context) => TimerCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes(
            mode: MyTheme.light,
            fontFamily: AppFonts.main,
          ).theme,
          home: const GameScreen(),
        ),
      ),
    ),
  );
}
