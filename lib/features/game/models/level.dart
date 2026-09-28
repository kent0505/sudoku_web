import 'package:flutter/material.dart';

enum Level {
  noob(40, 0),
  easy(36, 5),
  medium(32, 10),
  hard(28, 15),
  expert(24, 20),
  master(20, 25);

  const Level(
    this.openedCount,
    this.remainingWins,
  );

  final int openedCount;
  final int remainingWins;

  String name(BuildContext context) {
    return switch (this) {
      Level.noob => 'Noob',
      Level.easy => 'Easy',
      Level.medium => 'Medium',
      Level.hard => 'Hard',
      Level.expert => 'Expert',
      Level.master => 'Master',
    };
  }
}
