part of 'game_bloc.dart';

final class GameState {
  GameState({
    required this.level,
    required this.cells,
    required this.index,
    required this.mistakes,
    required this.hints,
    required this.notesMode,
    required this.stopped,
    required this.completedCells,
  });

  final Level level;
  final List<Cell> cells;
  final int index;
  final int mistakes;
  final int hints;
  final bool notesMode;
  final bool stopped;
  final Set<int> completedCells;

  factory GameState.initial() {
    return GameState(
      level: Level.noob,
      cells: [],
      index: 0,
      mistakes: 0,
      hints: 0,
      notesMode: false,
      stopped: false,
      completedCells: const {},
    );
  }

  GameState copyWith({
    Level? level,
    List<Cell>? cells,
    int? index,
    int? mistakes,
    int? hints,
    bool? notesMode,
    bool? stopped,
    Set<int>? completedCells,
  }) {
    return GameState(
      level: level ?? this.level,
      cells: cells ?? this.cells,
      index: index ?? this.index,
      mistakes: mistakes ?? this.mistakes,
      hints: hints ?? this.hints,
      notesMode: notesMode ?? this.notesMode,
      stopped: stopped ?? this.stopped,
      completedCells: completedCells ?? this.completedCells,
    );
  }

  bool get isLose => mistakes >= GameConfig.maxMistakes;
  bool get isWin =>
      cells.any((cell) => cell.value != 0) &&
      cells.every((cell) => cell.value == cell.number);
  bool get gameOver => isLose || isWin;
}
