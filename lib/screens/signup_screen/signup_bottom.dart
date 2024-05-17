import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';


class SignUpBottom extends StatelessWidget {
  const SignUpBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
         SizedBox(
              height:AppConstant.spaceBetweenTextFiled,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Divider(
                  color: Color(0xFFD9D9D9),
                  height: 1.5,
                )),
                Padding(
                    padding: EdgeInsets.all(4),
                    child: Text("OR",
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Divider(
                  color: Color(0xFFD9D9D9),
                  height: 1.5,
                ))
              ],
            ),
             SizedBox(
              height: AppConstant.spaceBetweenTextFiled,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonViews().iconShape(
                  child: SvgPicture.asset("assets/images/facebook.svg",
                  ),
                ),
                CommonViews().iconShape(
                  child: SvgPicture.asset(
                    "assets/images/twitter.svg",
                  ),
                ),
                CommonViews().iconShape(
                  child: SvgPicture.asset(
                    "assets/images/google-plus.svg",

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
