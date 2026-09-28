import 'package:flutter/material.dart';

import 'themes.dart';

extension Context on BuildContext {
  double get top => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewPadding.bottom;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  MyColors get colors => Theme.of(this).extension<MyColors>()!;

  // navigation
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> replace<T>(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
