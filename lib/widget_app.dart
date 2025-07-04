
import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/ficha_bda_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetApp extends StatelessWidget {
  const WidgetApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (BuildContext context) => FichaBdaController(),

      builder:(context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(1)), 
          child: child!
        );
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              textStyle: Theme.of(context).textTheme.titleMedium,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
          textTheme: TextTheme(
            titleMedium: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.fade,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            labelLarge: TextStyle(
              fontSize: 30,
              overflow: TextOverflow.clip,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            labelMedium: TextStyle(
              fontSize: 24,
              overflow: TextOverflow.clip,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            labelSmall: TextStyle(
              fontSize: 18,
              overflow: TextOverflow.clip,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        home: SafeArea(child: FichaBDAPage()),
      ),
    );
  }
}