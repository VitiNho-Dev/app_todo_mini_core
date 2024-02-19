import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final AnimationController _rotationController;

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: const Offset(-3, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _slideController,
    curve: Curves.elasticIn,
  ));

  late final Animation<double> _rotationAnimation = CurvedAnimation(
    parent: _rotationController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideController.forward();

    _slideAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final ticket = _rotationController.forward();

        ticket.whenComplete(() {
          Routefly.navigate(routePaths.home);
        });
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: RotationTransition(
                turns: _rotationAnimation,
                child: const FlutterLogo(
                  size: 75,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Splash Page'),
          ],
        ),
      ),
    );
  }
}
