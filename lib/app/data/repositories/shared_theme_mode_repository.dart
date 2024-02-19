import 'dart:convert';

import 'package:app_mini_core/app/data/adapters/theme_adapter.dart';
import 'package:app_mini_core/app/interactor/models/theme_model.dart';
import 'package:app_mini_core/app/interactor/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _key = 'THEME_MODE';

class SharedThemeModeRepository implements ThemeModeRepository {
  @override
  Future<ThemeModel> saveThemeMode(ThemeModel theme) async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '{}';
    final map = jsonDecode(json) as Map<String, dynamic>;
    final saveTheme = ThemeAdapter.toMap(theme);
    await shared.setString(_key, jsonEncode(saveTheme));
    return theme;
  }

  @override
  Future<ThemeModel> getThemeMode() async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '{}';
    final map = jsonDecode(json) as Map<String, dynamic>;
    final themeMode = ThemeAdapter.fromMap(map);
    return themeMode;
  }
}
