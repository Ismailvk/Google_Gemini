import 'package:flutter/material.dart';
import 'package:google_gemini/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade800,
          primaryColor: Colors.deepPurple.shade300),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
