import 'package:flutter/material.dart';
import 'package:tikle2_vue/screens/admin/common/splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ArticleManagerApp());
}

class ArticleManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Articles',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
