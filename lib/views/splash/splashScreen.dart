import 'dart:async';

import 'package:e_book/utils/exports.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// int? isViewed;
class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  void splashDuration() {
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => user == null ? OnBoardingScreen() : LoginScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    splashDuration();
    // _isViewedOnBoarding();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Image.asset(
            'assets/icons/logo.png',
            height: Get.height * 0.5,
            width: Get.width * 0.5,
          ),
        ),
      ),
    );
  }
}
