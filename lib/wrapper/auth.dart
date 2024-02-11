import 'package:flutter/material.dart';
import 'package:hackthisfall/data/shared_preferesence.dart';
import 'package:hackthisfall/screens/home_screen.dart';
import 'package:hackthisfall/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final val = SharedPref().fetchStoredValue();
    if (val == '') {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
