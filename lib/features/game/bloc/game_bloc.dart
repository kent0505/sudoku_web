import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../data/game_repository.dart';
import '../models/cell.dart';
import '../models/level.dart';
import '../models/sudoku.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository;

  final _sudoku = Sudoku();

  GameBloc({required GameRepository repository})
      : _repository = repository,
        super(GameState.initial()) {
    on<GameEvent>(
      (event, emit) => switch (event) {
        NewGame() => _newGame(event, emit),
        SelectCell() => _selectCell(event, emit),
        WriteNumber() => _writeNumber(event, emit),
        UseHint() => _useHint(event, emit),
        ClearCell() => _clearCell(event, emit),
        ToggleNotes() => _toggleNotes(event, emit),
      },
    );
  }

  void _newGame(
    NewGame event,
    Emitter<GameState> emit,
  ) async {
    final cells = _sudoku.generateSolved();
    _sudoku.shuffleSudoku(cells);
    _sudoku.generatePuzzle(cells, event.level.openedCount);

    final hints = _repository.getHints();
    // final hints = 100;

    emit(state.copyWith(
      level: event.level,
      cells: cells,
      mistakes: 0,
      hints: event.isWin ? await _repository.saveHints(hints + 3) : hints,
    ));
  }

  void _selectCell(
    SelectCell event,
    Emitter<GameState> emit,
  ) {
    final index = event.index;
    final cell = state.cells[index];
    logger(cell.number);
    emit(state.copyWith(index: index));
  }

  void _writeNumber(
    WriteNumber event,
    Emitter<GameState> emit,
  ) async {
    final cell = state.cells[state.index];
    final value = event.value;
    if (cell.opened || cell.value == cell.number) return;
    if (cell.cleaned) {
      cell.cleaned = false;
      cell.value = 0;
      cell.notes.clear();
    }
    if (state.notesMode) {
      cell.value = 0;
      cell.notes.contains(value)
          ? cell.notes.remove(value)
          : cell.notes.add(value);
      emit(state.copyWith());
    } else {
      cell.value = value;
      cell.notes.clear();
      final correct = value == cell.number;
      emit(state.copyWith(mistakes: correct ? null : state.mistakes + 1));
      await _emitCompletedCells(emit, state.index);
    }
  }

  void _useHint(
    UseHint event,
    Emitter<GameState> emit,
  ) async {
    final cells = List<Cell>.from(state.cells)..shuffle();
    final cell = cells.firstWhereOrNull((element) => element.value == 0);
    if (cell == null) return;
    final hintIndex = state.cells.indexOf(cell);
    cell.cleaned = false;
    cell.value = cell.number;
    cell.notes.clear();

    emit(state.copyWith(
      hints: await _repository.saveHints(state.hints - 1),
    ));
    await _emitCompletedCells(emit, hintIndex);
  }

  void _clearCell(
    ClearCell event,
    Emitter<GameState> emit,
  ) async {
    final cell = state.cells[state.index];
    if (cell.value == cell.number ||
        cell.opened ||
        (cell.value == 0 && cell.notes.isEmpty)) {
      return;
    }
    cell.cleaned = true;
    emit(state.copyWith());
  }

  void _toggleNotes(
    ToggleNotes event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(notesMode: !state.notesMode));
  }

  Future<void> _emitCompletedCells(
    Emitter<GameState> emit,
    int changedIndex,
  ) async {
    final completed = _sudoku.getCompletedCells(state.cells, changedIndex);
    if (completed.isEmpty) return;
    emit(state.copyWith(completedCells: completed));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(state.copyWith(completedCells: {}));
  }
}
