import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client/client_home.dart';
import '../../login_screen.dart';
import '../admin_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final role = prefs.getString('role');

    Future.delayed(Duration(seconds: 2), () {
      if (isLoggedIn) {
        if (role == 'admin') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminHome()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientHome()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}