import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';

abstract interface class GameRepository {
  const GameRepository();

  int getHints();
  Future<int> saveHints(int value);
}

final class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  int getHints() {
    return _prefs.getInt(Keys.hint) ?? 3;
  }

  @override
  Future<int> saveHints(int value) async {
    await _prefs.setInt(Keys.hint, value);
    return value;
  }
}
