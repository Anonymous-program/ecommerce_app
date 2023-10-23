import 'package:ecommerce_app/auth/auth_service.dart';
import 'package:ecommerce_app/pages/dashboad_screen.dart';
import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatefulWidget {
  static const String routeName = '/';
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      if (AuthServices.currentUser!=null) {
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
