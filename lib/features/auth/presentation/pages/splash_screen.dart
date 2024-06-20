import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.of(context).pushReplacementNamed('/login')
          : Navigator.of(context).pushReplacementNamed('/discover');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/svg/brand.svg',
                height: 100), // Replace with your logo
            const SizedBox(height: 20),
            Text(
              "Get Your Favourite Shoes",
              style: AppTextStyles.boldStyle20,
            ),
            Text(
              "TODAY",
              style: AppTextStyles.semiboldStyle24,
            ),
          ],
        ),
      ),
    );
  }
}
