// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/admin_home_page.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_page.dart';
import 'package:update_flutter_project_one/screens/login_screen/login_top.dart';
import 'package:update_flutter_project_one/screens/signup_screen/signup_page.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _passController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passFocusNode = FocusNode();

  bool showErrorEmail = false;

  bool showErrorPassword = false;
  bool dontShowPassword = true;
  IconData eye = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginTop(),
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: CommonViews().createTextFormField(
                        radius: 20,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (value) {
                          _passFocusNode.requestFocus();
                        },
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "This Field is required";
                          }
                          if (!CommonViews().isEmail(_emailController.text)) {
                            return "Please Enter Valid Email";
                          }
                          return null;
                        },
                        errorText: showErrorEmail ? "Enter Valid Email" : null,
                        prefixIcon: Icons.person,
                        hint: "Peeely@mail.com",
                      ),
                    ),
                    SizedBox(
                      height: AppConstant.spaceBetweenTextFiled,
                    ),
                    SizedBox(
                      width: 80.w,
                      child: CommonViews().createTextFormField(
                          controller: _passController,
                          radius: 20,
                          focusNode: _passFocusNode,
                          isObscure: dontShowPassword,
                          keyboardType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.done,
                          onSubmitted: (value) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "This Field is required";
                            }
                            if (!CommonViews()
                                .validPassword(_passController.text)) {
                              return "Please Enter Strong password more than 3 character";
                            }
                            return null;
                          },
                          errorText: showErrorPassword
                              ? " Enter Valid Password"
                              : null,
                          prefixIcon: Icons.lock,
                          hint: "..........",
                          suffixIcon: IconButton(
                              onPressed: () {
                                dontShowPassword = !dontShowPassword;
                                if (dontShowPassword) {
                                  eye = Icons.visibility_off;
                                } else {
                                  eye = Icons.visibility;
                                }
                                setState(() {});
                              },
                              icon: Icon(eye,
                                  color: Colors.deepPurpleAccent, size: 25))),
                    ),
                    SizedBox(
                      height: AppConstant.spaceBetweenTextFiled,
                    ),
                    CommonViews().customButton(
                      textButton: "LOGIN",
                      context: MediaQuery.of(context),
                      onTap: () {
                        // if (_key.currentState!.validate()) {
                        //   AppNavigator.of(context, isAnimated: true)
                        //       .push(const HomePage());
                        //   login(
                        //       email: _emailController.text,
                        //       password: _passController.text);
                        // }
                        AppNavigator.of(context, isAnimated: true)
                            .pushAndRemoveUntil(const AdminHomePage());
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppConstant.spaceBetweenWidget,
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              child: RichText(
                text: TextSpan(
                  text: 'Dont have account ? ',
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppNavigator.of(context, isAnimated: true)
                                .push(const SignUpPage());
                          },
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  login({required String email, required String password}) async {
    EasyLoading.show(status: 'loading...');

    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}login.php"),
      body: {"Email": email, "Password": password},
    );
    EasyLoading.dismiss();
    var jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonBody['result']) {
        CommonViews.savePrefString(ConsValues.ID, jsonBody['Id']);
        CommonViews.savePrefString(ConsValues.NAME, jsonBody['Name']);
        CommonViews.savePrefString(ConsValues.EMAIL, jsonBody['Email']);
        CommonViews.savePrefString(ConsValues.PHONE, jsonBody['Phone']);
        CommonViews.savePrefString(ConsValues.USERTYPE, jsonBody['UserType']);
        if (jsonBody['UserType'] == "1" && mounted) {
          AppNavigator.of(context, isAnimated: true)
              .push(const HomePage());
        }else{

        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                width: 300,
                height: 250,
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(jsonBody['msg'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                      child: const Text("OK",
                          style: TextStyle(
                              fontSize: 30, color: Colors.deepPurpleAccent)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }
}
