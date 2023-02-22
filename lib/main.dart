import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/dependency_injections.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito_dating_app/ui/routes/pages.dart';
import 'package:mockito_dating_app/ui/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DependencyInjections.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final adminsCollectFB = FirebaseFirestore.instance.collection('admins');
  final datesCollectFB = FirebaseFirestore.instance.collection('dates');
  final usersCollectFB = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    DependencyInjections.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme.instance,
      child: Consumer<MyAppTheme>(
        builder: (_, myAppTheme, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: MyAppTheme.instance.theme
                ? ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(
                      surface: Color(0xff102027), // APPBAR Color
                      primary: Color(0xff102027),
                      onPrimary: Colors.black,
                      secondary: Color(0xff121212),
                      background: Color(0xff121212),
                      error: Color(0xff102027),
                      primaryContainer: Color(0xff37474f),
                      secondaryContainer: Color(0xff121212),
                    ),
                    scaffoldBackgroundColor:
                        const Color(0xff37474f), // SCAFFOLD background Color
                    toggleableActiveColor:
                        const Color(0xffcfd8dc), // BUTTON Switch Color
                  )
                : ThemeData.light().copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: const MaterialColor(
                        0xffaf4448,
                        {
                          50: Color(0xffffebee),
                          100: Color(0xffffebee),
                          200: Color(0xffffcccb),
                          300: Color(0xffffcccb),
                          400: Color(0xffef9a9a),
                          500: Color(0xffef9a9a),
                          600: Color(0xffba6b6c),
                          700: Color(0xffba6b6c),
                          800: Color(0xffaf4448),
                          900: Color(0xffaf4448),
                        },
                      ),
                      primaryColorDark: const Color(0xffaf4448),
                    ).copyWith(
                      secondary: const Color(0xffffcccb),
                    ),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
            initialRoute: Pages.initial,
            routes: Pages.routes,
          );
        },
      ),
    );
  }
}
