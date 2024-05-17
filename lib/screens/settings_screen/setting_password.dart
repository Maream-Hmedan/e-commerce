import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';
import 'package:http/http.dart' as http;

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController password = TextEditingController();
  final FocusNode passFocusNode = FocusNode();

  final TextEditingController passwordCon = TextEditingController();
  final FocusNode passwordConFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool dontShowPassword = true;
    IconData eye = Icons.visibility_off;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            SizedBox(
              width: 80.w,
              child: CommonViews().createTextFormField(
                  controller: password,
                  focusNode: passFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  isObscure: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "This Field is required";
                    }
                    if (!CommonViews().validPassword(password.text)) {
                      return "Please Enter Strong password more than 3 character";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(eye, color: Colors.deepPurpleAccent, size: 25),
                    onPressed: () {
                      dontShowPassword = !dontShowPassword;
                      if (dontShowPassword) {
                        eye = Icons.visibility_off;
                      } else {
                        eye = Icons.visibility;
                      }
                      setState(() {});
                    },
                  ),
                  prefixIcon: Icons.lock,
                  label: "New Password"),
            ),
            SizedBox(
              height: AppConstant.spaceBetweenTextFiled,
            ),
            SizedBox(
              width: 80.w,
              child: CommonViews().createTextFormField(
                controller: passwordCon,
                focusNode: passwordConFocusNode,
                keyboardType: TextInputType.visiblePassword,
                inputAction: TextInputAction.done,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                isObscure: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "This Field is required";
                  }
                  if (!CommonViews().validPassword(password.text)) {
                    return "Please Enter Strong password more than 3 character";
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(eye, color: Colors.deepPurpleAccent, size: 25),
                  onPressed: () {
                    dontShowPassword = !dontShowPassword;
                    if (dontShowPassword) {
                      eye = Icons.visibility_off;
                    } else {
                      eye = Icons.visibility;
                    }
                    setState(() {});
                  },
                ),
                prefixIcon: Icons.lock,
                label: "Config New Password",
              ),
            ),
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            CommonViews().customButton(
                textButton: "Save",
                context: MediaQuery.of(context),
                onTap: () {
                  if (password.text == passwordCon.text) {
                    updatePassword();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.error),
                          content: const Text("password does not match"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("ok"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  updatePassword() {
    CommonViews.getPrefString(ConsValues.ID, "").then((idUser) async {
      final response = await http.post(
        Uri.parse(
          "${ConsValues.BASEURL}updatePassword.php",
        ),
        body: {
          "Id": idUser,
          "Password": password.text,
        },
      );
      if (response.statusCode == 200 && mounted) {
        CommonViews.savePrefString(ConsValues.PASSWORD, password.text);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.update),
              content: const Text("Your Password Update"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("ok"),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
