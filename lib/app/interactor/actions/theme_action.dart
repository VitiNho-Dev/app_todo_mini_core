import 'package:app_mini_core/app/interactor/atoms/theme_atom.dart';
import 'package:app_mini_core/app/interactor/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

import '../../injector.dart';
import '../models/theme_model.dart';

Future<void> getTheme() async {
  final repository = injector.get<ThemeModeRepository>();
  final theme = await repository.getThemeMode();
  themeAtom.value = theme.themeMode;
}

void changeTheme()  {

  themeAtom.value = !themeAtom.value;

  final repository = injector.get<ThemeModeRepository>();
  final theme = ThemeModel(themeMode: themeAtom.value);
  repository.saveThemeMode(theme);
}
