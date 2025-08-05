import 'package:flutter/material.dart';
import 'package:tikle2_vue/screens/admin/article_list.dart';
import 'package:tikle2_vue/screens/admin/common/splash.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tikle2_vue/screens/client/client_home.dart';
import 'package:tikle2_vue/screens/login_screen.dart';
import 'package:tikle2_vue/screens/register_screen.dart';

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
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/admin_home': (context) => ArticleListAdminScreen(),
        '/client_home': (context) => ClientHome(),
        // tu peux ajouter d'autres routes ici
      },
    );
  }
}
