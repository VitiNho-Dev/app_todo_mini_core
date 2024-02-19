import 'package:app_mini_core/app/interactor/models/theme_model.dart';

class ThemeAdapter {
  static Map<String, dynamic> toMap(ThemeModel theme) {
    return {
      'themeMode': theme.themeMode,
    };
  }

  static ThemeModel fromMap(Map<String, dynamic> json) {
    return ThemeModel(
      themeMode: json['themeMode'] ?? true,
    );
  }
}
