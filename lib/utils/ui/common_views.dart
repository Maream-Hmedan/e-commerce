import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:update_flutter_project_one/configuration/app_colors.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_view.dart';
import 'package:update_flutter_project_one/screens/settings_screen/settings_screen.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';

class CommonViews {
  CommonViews._private();

  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  Widget customAppBar({required String title, required BuildContext context}) {
    final mediaQuery = MediaQuery.of(context); // Get MediaQueryData
    return Stack(
      children: [
        SizedBox(
          width: mediaQuery.size.width, // Access width from MediaQueryData
          height: mediaQuery.size.height * 0.17,
        ),
        FadeInDown(
          delay: const Duration(milliseconds: 1000),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              color:AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
          ),
        ),
        Positioned(
          top: 35,
          child: FadeInRight(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      AppNavigator.of(context, isAnimated: true)
                          .push(const SettingsScreen());
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 25,
                    )),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  width: 200,
                ),
                IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 25,
                    )),
                IconButton(
                  onPressed: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const OrderHesScreen());
                  },
                  icon: const Icon(
                    Icons.local_grocery_store,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 30,
          left: 30,
          top: 90,
          child: FadeInUp(
            delay: const Duration(milliseconds: 1000),
            child: const TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: "Search here",
                  suffixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
        ),
      ],
    );
  }

  Widget customButton(
      {required textButton, context, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        width: context.size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          textButton,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget createTextFormField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      String? label,
      required TextInputType keyboardType,
      TextInputAction? inputAction,
      final double? radius,
      ValueChanged<String>? onSubmitted,
      String? prefixText,
      String? hint,
      Widget? suffixIcon,
      IconData? prefixIcon,
      String? errorText,
      FormFieldValidator<String>? validator,
      bool isObscure = false}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: inputAction ?? TextInputAction.next,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        prefixIcon: Icon(
          prefixIcon,
          size: 25,
          color: AppColors.primaryColor,
        ),
        filled: true,
        fillColor: AppColors.lightPrimaryColor,
        prefix: Text(prefixText ?? ''),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        border: _getBorder(radius),
        // enabledBorder: _getBorder(borderRadius??20),
        // disabledBorder: _getBorder(),
        // focusedBorder: _getBorder(),
      ),
    );
  }

  OutlineInputBorder _getBorder(radius) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide.none);
  }

  Widget iconShape({required child}) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.primaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }

  bool validPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{,3}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static savePrefString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static savePrefInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  static savePrefBoll(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static savePrefDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(key, value);
  }

  static savePrefStringList(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(key, value);
  }

  static Future<String> getPrefString(String key, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  static Future<int> getPrefInt(String key, int defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? defaultValue;
  }

  static remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,
          duration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeInOut,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          message: message,
          backgroundColor: Colors.red,
        )..show(context));
  }
}
