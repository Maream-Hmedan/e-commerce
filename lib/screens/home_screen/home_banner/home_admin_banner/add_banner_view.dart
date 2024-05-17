import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/app_colors.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_users_banner/banner_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({Key? key}) : super(key: key);

  @override
  State<AddBannerScreen> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBannerScreen> {
  final TextEditingController _url = TextEditingController();
  final FocusNode _urlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Select Image"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<BannerProv>(context, listen: false)
                                  .getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<BannerProv>(context, listen: false)
                                  .getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.browse_gallery),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 100.w,
                height: 20.h,
                child: Consumer<BannerProv>(
                  builder: (context, value, child) {
                    return value.image != null
                        ? Image.file(
                            value.image!,
                            width: 100.w,
                            height: 20.h,
                            fit: BoxFit.fill,
                          )
                        : const Icon(
                            (Icons.image),
                          );
                  },
                ),
              ),
            ),
            SizedBox(
              height: AppConstant.spaceBetweenButtonInAdmin,
            ),
            CommonViews().createTextFormField(
                controller: _url,
                focusNode: _urlFocusNode,
                keyboardType: TextInputType.name,
                label: " Image URL",
                hint: "ADD URL",
                prefixIcon: Icons.image_rounded,
                suffixIcon: const Icon(
                  Icons.photo_album,
                  color: AppColors.primaryColor,
                ),
              inputAction: TextInputAction.done,
              onSubmitted: (value) {
                FocusManager.instance.primaryFocus!.unfocus();
              },),
            SizedBox(
              height: 7.h,
            ),
            CommonViews().customButton(
                textButton: "Save",
                context: MediaQuery.of(context),
                onTap: () async {
                  await Provider.of<BannerProv>(context, listen: false)
                      .addNewBanner(url: _url.text);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
