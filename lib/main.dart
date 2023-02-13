import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workshop_app/features/workshop/screens/workshop_screen.dart';
import 'package:workshop_app/languagefolder/Localization/demo_localization.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This method is important Also
  static void setLocal(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocal(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  //
  Locale? _locale;

  void setLocal(Locale? locale) {
    setState(() {
      _locale = locale;
    });
  }

  //
  @override
  void didChangeDependencies() {
    //
    getLocal().then((local) {
      setState(() {
        _locale = local;
      });
    });
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Banker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Color(0xFFFEF9EB),
        // Define the default font family.
      ),
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "SA"),
      ],
      locale: _locale,
      localizationsDelegates: const [
        //
        DemoLocalization.delegate,
        //
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var local in supportedLocales) {
          if (local.languageCode == deviceLocal!.languageCode &&
              local.countryCode == deviceLocal.countryCode) {
            return deviceLocal;
          }
        }

        // This Return if The for loop for checking device langauge is not contain any one of language
        // Return The first Language From This List supportedLocales: const [
        //   Locale("en", "US"),
        //   Locale("ar", "SA"),
        // ],
        return supportedLocales.first;
      },
      home: const WorkshopScreen(),
    );
  }
}
