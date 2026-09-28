import 'dart:math';

import 'cell.dart';

class Sudoku {
  List<Cell> generateSolved() {
    List<Cell> result = [];
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        int value = (row * 3 + row ~/ 3 + col) % 9 + 1;
        result.add(Cell(
          number: value,
          notes: [],
        ));
      }
    }
    return result;
  }

  void shuffleSudoku(List<Cell> cells) {
    final rand = Random();
    for (int block = 0; block < 3; block++) {
      int base = block * 3;
      int r1 = base + rand.nextInt(3);
      int r2 = base + rand.nextInt(3);
      for (int col = 0; col < 9; col++) {
        int i1 = r1 * 9 + col;
        int i2 = r2 * 9 + col;
        final temp = cells[i1];
        cells[i1] = cells[i2];
        cells[i2] = temp;
      }
    }
    for (int block = 0; block < 3; block++) {
      int base = block * 3;
      int c1 = base + rand.nextInt(3);
      int c2 = base + rand.nextInt(3);
      for (int row = 0; row < 9; row++) {
        int i1 = row * 9 + c1;
        int i2 = row * 9 + c2;
        final temp = cells[i1];
        cells[i1] = cells[i2];
        cells[i2] = temp;
      }
    }
  }

  void generatePuzzle(
    List<Cell> cells,
    int openedCount,
  ) {
    final indexes = List.generate(81, (i) => i)..shuffle();
    for (int i = 0; i < openedCount; i++) {
      final index = indexes[i];
      final cell = cells[index];
      cell.value = cell.number;
      cells[index] = Cell(
        number: cell.number,
        value: cell.number,
        opened: true,
        notes: [],
      );
    }
  }

  bool isRowFilled(List<Cell> cells, int row) {
    for (int i = 0; i < 9; i++) {
      final cell = cells[row * 9 + i];
      if (cell.value != cell.number) return false;
    }
    return true;
  }

  bool isColFilled(List<Cell> cells, int col) {
    for (int i = 0; i < 9; i++) {
      final cell = cells[i * 9 + col];
      if (cell.value != cell.number) return false;
    }
    return true;
  }

  bool isBoxFilled(List<Cell> cells, int row, int col) {
    final startRow = (row ~/ 3) * 3;
    final startCol = (col ~/ 3) * 3;
    for (int r = startRow; r < startRow + 3; r++) {
      for (int c = startCol; c < startCol + 3; c++) {
        final cell = cells[r * 9 + c];
        if (cell.value != cell.number) return false;
      }
    }
    return true;
  }

  Set<int> getCompletedCells(
    List<Cell> cells,
    int index,
  ) {
    if (cells.every((e) => e.value == e.number)) {
      return List.generate(81, (i) => i).toSet();
    }
    final completed = <int>{};
    final row = index ~/ 9;
    final col = index % 9;
    if (isRowFilled(cells, row)) {
      for (int c = 0; c < 9; c++) {
        completed.add(row * 9 + c);
      }
    }
    if (isColFilled(cells, col)) {
      for (int r = 0; r < 9; r++) {
        completed.add(r * 9 + col);
      }
    }
    if (isBoxFilled(cells, row, col)) {
      final startRow = (row ~/ 3) * 3;
      final startCol = (col ~/ 3) * 3;
      for (int r = startRow; r < startRow + 3; r++) {
        for (int c = startCol; c < startCol + 3; c++) {
          completed.add(r * 9 + c);
        }
      }
    }
    return completed;
  }
}
