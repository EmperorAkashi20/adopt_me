import 'package:flutter/material.dart';

import '../Utils/adopt_me_preferences.dart';
import '../main.dart';

class ThemeFab extends StatefulWidget {
  const ThemeFab({super.key});

  @override
  _ThemeFabState createState() => _ThemeFabState();
}

class _ThemeFabState extends State<ThemeFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  Animation<Color?>? _animateColor;
  Animation<double>? _animateIcon;
  final Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor!.value,
      onPressed: () {
        animate();
        if (!adoptMePref.containsKey(PrefKey.THEME_STATUS) ||
            adoptMePref.getBool(PrefKey.THEME_STATUS) == false) {
          MyApp.of(context).changeTheme(ThemeMode.system);
          adoptMePref.setBool(PrefKey.THEME_STATUS, true);
        } else {
          adoptMePref.setBool(PrefKey.THEME_STATUS, false);
          MyApp.of(context).changeTheme(ThemeMode.system);
        }
      },
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        color: Colors.blue,
        size: 40,
        progress: _animateIcon!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
