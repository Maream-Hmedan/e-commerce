import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginTop extends StatelessWidget {
   const LoginTop({super.key});


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/background.png",
              ))),
      child: FadeInUp(
        delay: const Duration(milliseconds: 1000),
        child: Stack(
          children: [
            SizedBox(
              height: 50.h, width: 100.w,),
            Positioned(
              top: 0,
              left: 10.w,
              child: Image.asset(
                "assets/images/light-1.png",
              ),
            ),
            Positioned(
              top: 0,
              left: 40.w,
              child: Image.asset(
                "assets/images/light-2.png",
              ),
            ),
            Positioned(
              top: 10.h,
             right: 10.w,
              child: Image.asset(
                width: 14.w,
                "assets/images/clock.png",
              ),
            ),
            Positioned(
                top: 30.h,
                right: 33.w,
                child:const Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }
}
