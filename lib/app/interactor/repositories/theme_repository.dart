import 'package:app_mini_core/app/interactor/models/theme_model.dart';

abstract class ThemeModeRepository {
  Future<ThemeModel> getThemeMode();

  Future<ThemeModel> saveThemeMode(ThemeModel theme);
}
