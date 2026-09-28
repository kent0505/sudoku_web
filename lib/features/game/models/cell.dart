import 'dart:convert';

final class Cell {
  Cell({
    this.id = 0,
    required this.number,
    this.value = 0,
    this.cleaned = false,
    this.opened = false,
    required this.notes,
  });

  final int id;
  final int number;
  int value;
  bool cleaned;
  final bool opened;
  List<int> notes;

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'value': value,
      'opened': opened ? 1 : 0,
      'notes': jsonEncode(notes),
    };
  }

  static Cell fromMap(Map<String, dynamic> map) {
    return Cell(
      id: map['id'],
      number: map['number'],
      value: map['value'],
      opened: map['opened'] == 1,
      notes: List<int>.from(jsonDecode(map['notes'])),
    );
  }

  static const table = 'Cell';
  static const create = '''
    CREATE TABLE IF NOT EXISTS $table (
      id INTEGER PRIMARY KEY,
      number INTEGER,
      value INTEGER,
      opened INTEGER,
      notes TEXT
    )
    ''';
}
