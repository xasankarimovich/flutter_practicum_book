import 'package:buksam_flutter_practicum/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
      ),
      home: LoginScreen()
    );
  }
}