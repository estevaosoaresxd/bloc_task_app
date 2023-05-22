import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/login_screen.dart';
import 'package:flutter_tasks_app/screens/tabs_screen.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _getStorage = GetStorage();
  @override
  void initState() {
    super.initState();

    openNextPage(context);
  }

  void openNextPage(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () {
        if (_getStorage.read('token') != null &&
            _getStorage.read('token').isNotEmpty) {
          Navigator.pushReplacementNamed(context, TabsScreen.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
      },
    );
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
