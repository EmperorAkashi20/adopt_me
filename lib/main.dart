import 'package:adopt_me/Utils/adopt_me_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeDataPvd = ref.read(darkThemeProvider);
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          title: 'Adopt Me',
          // theme: Styles.themeData(themeDataPvd.darkTheme, context),
          home: const Home(),
        );
      },
    );
  }
}
