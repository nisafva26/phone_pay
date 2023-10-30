import 'package:dreampot_phonepay/module/phone_pay-screen.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
          fontFamily: 'Avenir',
          brightness: Brightness.light,
          primaryColor: AppColors.lightBlue,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.lightBlue,
            elevation: 0.0,
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: const ColorScheme(
            primary: Colors.blue,
            secondary: Colors.blue,
            surface: Colors.black12,
            background: Colors.black12,
            error: Colors.red,
            onPrimary: Colors.black,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
      home: PhonePayScreen(),
    );
  }
}


