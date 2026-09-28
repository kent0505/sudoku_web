export 'extensions.dart';

abstract final class Constants {
  static const int milliseconds = 400;
}

abstract final class AppFonts {
  static const String main = 'ComicRelief';
}

abstract final class Assets {
  static const String ad = 'assets/icons/ad.svg';
  static const String back = 'assets/icons/back.svg';
  static const String clear = 'assets/icons/clear.svg';
  static const String close = 'assets/icons/close.svg';
  static const String done = 'assets/icons/done.svg';
  static const String hint = 'assets/icons/hint.svg';
  static const String language = 'assets/icons/language.svg';
  static const String lock = 'assets/icons/lock.svg';
  static const String logo = 'assets/icons/logo.svg';
  static const String noAd = 'assets/icons/no_ad.svg';
  static const String note = 'assets/icons/note.svg';
  static const String privacy = 'assets/icons/privacy.svg';
  static const String rate = 'assets/icons/rate.svg';
  static const String settings = 'assets/icons/settings.svg';
  static const String sound = 'assets/icons/sound.svg';
  static const String stats = 'assets/icons/stats.svg';
  static const String terms = 'assets/icons/terms.svg';
  static const String theme = 'assets/icons/theme.svg';
  static const String trash = 'assets/icons/trash.svg';
  static const String vibration = 'assets/icons/vibration.svg';

  static const String soundErase = 'sounds/sound_erase.mp3';
  static const String soundHint = 'sounds/sound_hint.mp3';
  static const String soundMistake = 'sounds/sound_mistake.mp3';
  static const String soundNumber = 'sounds/sound_number.mp3';
  static const String soundUI = 'sounds/sound_ui.mp3';
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
