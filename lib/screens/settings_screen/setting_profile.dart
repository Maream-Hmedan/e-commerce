import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';
import 'package:http/http.dart' as http;

class SettingProfile extends StatefulWidget {
  const SettingProfile({super.key});

  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  final TextEditingController _email = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _phone = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  bool showErrorEmail = false;
  bool showErrorPhone = false;
  bool showErrorName = false;

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    CommonViews.getPrefString(ConsValues.EMAIL, "").then((value) {
      _email.text = value;
    });

    CommonViews.getPrefString(ConsValues.PHONE, "").then((value) {
      _phone.text = value;
    });
    CommonViews.getPrefString(ConsValues.NAME, "").then((value) {
      _name.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _email,
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
                child: CommonViews().createTextFormField(
                  controller: _name,
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
                controller: _phone,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus!.unfocus();
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
              height: AppConstant.spaceBetweenWidget,
            ),
            CommonViews().customButton(textButton: "Save",
                context: MediaQuery.of(context),
                onTap: () {
              updateProfile();
            })
          ],
        ),
      ),
    );
  }

  updateProfile() async {
   CommonViews.getPrefString(ConsValues.ID, "").then((idUser) async {
      final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}updateProfile.php"),
        body: {
          "Id": idUser,
          "Email": _email.text,
          "Name": _name.text,
          "Phone": _phone.text,
        },
      );

      if (response.statusCode == 200) {
        CommonViews.savePrefString(ConsValues.NAME, _name.text);
        CommonViews.savePrefString(ConsValues.EMAIL, _email.text);
        CommonViews.savePrefString(ConsValues.PHONE, _phone.text);
        _get();
      }
    });
    Navigator.pop(context);
  }
}
