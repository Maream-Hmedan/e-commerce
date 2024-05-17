import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/screens/login_screen/login_page.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Timer(Duration(seconds: AppConstant.splashDurationBySecond), () {
      AppNavigator.of(context, isAnimated: true)
          .pushReplacement(const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.w,
              height: 60.h,
              child: Lottie.asset('assets/animation/Animation -ecommarce.json'),
            ),
             SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 100.w,
              child:  SpinKitDoubleBounce(
                color: Colors.white,
                size: 20.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
