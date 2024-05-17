import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';

class SignUpTop extends StatelessWidget {
  const SignUpTop({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50.w,
              ),
              Text(
                "SIGNUP",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent[100]),
              ),
            ],
          ),

          SvgPicture.asset("assets/images/signup.svg",
              width: 20.w, height: 20.h, fit: BoxFit.fill),
           SizedBox(
            height:AppConstant.spaceBetweenTextFiled,
          )
        ],
      ),
    );
  }
}
