import 'package:flutter/material.dart';

final class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.bg,
    required this.primary,
    required this.tertiary1,
    required this.tertiary2,
    required this.tertiary3,
    required this.text,
    required this.text2,
  });

  final Color bg;
  final Color primary;
  final Color tertiary1;
  final Color tertiary2;
  final Color tertiary3;
  final Color text;
  final Color text2;

  @override
  MyColors copyWith({
    Color? bg,
    Color? primary,
    Color? tertiary1,
    Color? tertiary2,
    Color? tertiary3,
    Color? text,
    Color? text2,
  }) {
    return MyColors(
      bg: bg ?? this.bg,
      primary: primary ?? this.primary,
      tertiary1: tertiary1 ?? this.tertiary1,
      tertiary2: tertiary2 ?? this.tertiary2,
      tertiary3: tertiary3 ?? this.tertiary3,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      bg: Color.lerp(bg, other.bg, t) ?? bg,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      tertiary1: Color.lerp(tertiary1, other.tertiary1, t) ?? tertiary1,
      tertiary2: Color.lerp(tertiary2, other.tertiary2, t) ?? tertiary2,
      tertiary3: Color.lerp(tertiary3, other.tertiary3, t) ?? tertiary3,
      text: Color.lerp(text, other.text, t) ?? text,
      text2: Color.lerp(text2, other.text2, t) ?? text2,
    );
  }
}

enum MyTheme {
  light(
    brightness: Brightness.light,
    colors: MyColors(
      bg: Color(0xffFCF8F8),
      primary: Color(0xff647FBC),
      tertiary1: Color(0xffFCF8F8), // dialog color
      tertiary2: Color(0xff647FBC), // selected cell color
      tertiary3: Color(0xffFF3737), // error
      text: Color(0xff1B211A),
      text2: Color(0xff888888),
    ),
  );

  const MyTheme({
    required this.brightness,
    required this.colors,
  });

  final Brightness brightness;
  final MyColors colors;
}

class Themes {
  Themes({
    required this.mode,
    required this.fontFamily,
  });

  final MyTheme mode;
  final String fontFamily;

  MyColors get colors => mode.colors;

  Brightness get brightness => mode.brightness;

  ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      fontFamily: fontFamily,
      brightness: brightness,
      scaffoldBackgroundColor: colors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
        surface: colors.bg, // bg color when push
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.tertiary1,
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.text,
        thickness: 1,
        indent: 44,
        endIndent: 44,
      ),
      extensions: [colors],
    );
  }
}
