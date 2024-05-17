import 'package:flutter/material.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/settings_screen/setting_password.dart';
import 'package:update_flutter_project_one/screens/settings_screen/setting_profile.dart';
import 'package:update_flutter_project_one/screens/splash/splash_screen.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Center(
        child: Column(
          children: [
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            CommonViews().customButton(
                textButton: "Profile",
                context: MediaQuery.of(context),
                onTap: () {
                  AppNavigator.of(context, isAnimated: true)
                      .push(const SettingProfile());
                }),
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            CommonViews().customButton(
                textButton: "Update PassWord",
                context: MediaQuery.of(context),
                onTap: () {
                  AppNavigator.of(context, isAnimated: true)
                      .push(const  PasswordScreen());
                }),
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            CommonViews().customButton(
                textButton: "LogOut",
                context: MediaQuery.of(context),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        icon: const Icon(Icons.logout_sharp),
                        content: const Text("Are You Sure You Want To LogOut"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await CommonViews.remove(ConsValues.ID);
                              if(mounted){
                                Navigator.pop(context);
                                AppNavigator.of(context,isAnimated: true).pushAndRemoveUntil(const SplashScreen());
                              }
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
