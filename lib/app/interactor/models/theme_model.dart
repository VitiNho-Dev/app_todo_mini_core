class ThemeModel {
  final bool themeMode;

  const ThemeModel({
    required this.themeMode,
  });

  ThemeModel copyWith({
    bool? themeMode,
  }) {
    return ThemeModel(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
