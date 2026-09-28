part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class NewGame extends GameEvent {
  NewGame({
    required this.level,
    this.isWin = false,
  });

  final Level level;
  final bool isWin;
}

final class SelectCell extends GameEvent {
  SelectCell({required this.index});

  final int index;
}

final class WriteNumber extends GameEvent {
  WriteNumber({required this.value});

  final int value;
}

final class UseHint extends GameEvent {}

final class ClearCell extends GameEvent {}

final class ToggleNotes extends GameEvent {}
