import 'package:adopt_me/Utils/adopt_me_preferences.dart';
import 'package:adopt_me/Utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'Screens/home_views.dart/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await adoptMePref.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const riverpod.ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: adoptMePref.getBool(PrefKey.THEME_STATUS) == null ||
              adoptMePref.getBool(PrefKey.THEME_STATUS) == false
          ? ThemeData.light()
          : ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const Home(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
