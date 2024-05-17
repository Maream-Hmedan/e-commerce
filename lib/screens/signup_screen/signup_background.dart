import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/signup_top.png",
    this.bottomImage = "assets/images/main_bottom.png",
  }) : super(key: key);
  final Widget child;
  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  topImage,
                  width: 40.w,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(bottomImage, width: 30.w),
              ),
              SafeArea(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
