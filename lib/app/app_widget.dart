import 'package:app_mini_core/app/interactor/actions/theme_action.dart';
import 'package:app_mini_core/app/interactor/atoms/theme_atom.dart';
import 'package:app_mini_core/routes.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return MaterialApp.router(
          title: 'ASP Arch',
          themeMode: themeAtom.value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          routerConfig: Routefly.routerConfig(
            routes: routes,
            initialPath: routePaths.splash,
          ),
        );
      },
    );
  }
}
