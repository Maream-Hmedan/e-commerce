// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/signup_screen/signup_bottom.dart';
import 'package:update_flutter_project_one/screens/signup_screen/signup_top.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';
import '../login_screen/login_page.dart';
import 'signup_background.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _passController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  final FocusNode _passFocusNode = FocusNode();

  bool showErrorEmail = false;
  bool showErrorPhone = false;
  bool showErrorName = false;

  bool showErrorPassword = false;
  bool dontShowPassword = true;
  IconData eye = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: FadeInUp(
        delay: const Duration(milliseconds: 1000),
        child: Column(
          children: [
            const SignUpTop(),
            Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    width: 80.w,
                    child: CommonViews().createTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (value) {
                        _nameFocusNode.requestFocus();
                      },
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "This Field is required";
                        }
                        if (!CommonViews().isEmail(v)) {
                          return "Please Enter Valid Email";
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      hint: "Peeely@mail.com",
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.spaceBetweenTextFiled,
                  ),
                  SizedBox(
                      width: 80.w,
                      child:
                      CommonViews().createTextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        keyboardType: TextInputType.name,
                        onSubmitted: (value) {
                          _phoneFocusNode.requestFocus();
                        },
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "This Field is required";
                          }
                          return null;
                        },
                        errorText:
                            showErrorName ? "Your Name Is Required" : null,
                        prefixIcon: Icons.person,
                        hint: "Enter your first name",
                      )),
                  SizedBox(
                    height: AppConstant.spaceBetweenTextFiled,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: CommonViews().createTextFormField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      onSubmitted: (value) {
                        _passFocusNode.requestFocus();
                      },
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "This Field is required";
                        }
                        return null;
                      },
                      prefixIcon: Icons.phone_android,
                      errorText:
                          showErrorPhone ? "Your Phone Is Required" : null,
                      hint: "07........",
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.spaceBetweenTextFiled,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: CommonViews().createTextFormField(
                      controller: _passController,
                      focusNode: _passFocusNode,
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
                        if (!CommonViews()
                            .validPassword(_passController.text)) {
                          return "Please Enter Strong password more than 3 character";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon:
                            Icon(eye, color: Colors.deepPurpleAccent, size: 25),
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
                      hint: "........",
                    ),
                  ),
                  CommonViews().customButton(
                    textButton: "SIGNUP",
                    context: MediaQuery.of(context),
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        signUp();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppConstant.spaceBetweenTextFiled,
            ),
            RichText(
              text: TextSpan(
                text: 'Already Have An  Account ? ',
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign In',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppNavigator.of(context, isAnimated: true)
                              .pushReplacement(const LoginPage());
                        },
                      style: const TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SignUpBottom()
          ],
        ),
      ),
    );
  }

  signUp() async {
    EasyLoading.show(status: 'loading...');

    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}SignUp.php"),
      body: {"Email": _emailController, "Password": _passController},
    );
    EasyLoading.dismiss();
    var jsonBody = jsonDecode(response.body);
    if (response.statusCode == 100) {
      if (jsonBody['result'] && mounted) {
        AppNavigator.of(context, isAnimated: true).pop();
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
                    const Text("signUp failed email exist",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
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
