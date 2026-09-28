export 'extensions.dart';

abstract final class Constants {
  static const int milliseconds = 400;
}

abstract final class AppFonts {
  static const String main = 'ComicRelief';
}

abstract final class Assets {
  static const String clear = 'assets/icons/clear.svg';
  static const String hint = 'assets/icons/hint.svg';
  static const String note = 'assets/icons/note.svg';
}

abstract final class Keys {
  static const String hint = 'hint';
}

abstract final class GameConfig {
  static const int maxMistakes = 3;
  static const gameDuration = Duration(minutes: 30);
  static int get maxSeconds => gameDuration.inSeconds;
  static int get maxMinutes => gameDuration.inMinutes;
}

enum OverReason { win, lose, time }
