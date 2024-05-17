// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_users_banner/banner_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_users_banner/banner_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';


class EditBannerScreen extends StatefulWidget {
  BannerImages bannerImages;

  EditBannerScreen({super.key, required this.bannerImages});

  @override
  State<EditBannerScreen> createState() => _EditBannerScreenState();
}


class _EditBannerScreenState extends State<EditBannerScreen> {
  final TextEditingController _url = TextEditingController();
  final FocusNode _urlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _url.text = widget.bannerImages.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
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
                              Provider.of<BannerProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<BannerProv>(context, listen: false).
                              getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.browse_gallery),
                          ),
                        ],
                      );
                    });
              },
              child:
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    height: (3.h) - 16,
                    width: (100.w) - 16,
                    fit: BoxFit.fill,
                    imageUrl: ConsValues.BASEURL +
                        widget.bannerImages.imageURL,
                    progressIndicatorBuilder: (context, url,
                        downloadProgress) =>
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: Container(
                            color: Colors.grey[300]!,
                            height: (3.h) - 16,
                            width: 100.w - 16,
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),

                ),
              ),
            ),
            SizedBox(height: 3.h,),
            CommonViews().createTextFormField(controller: _url,
                focusNode: _urlFocusNode,
                keyboardType:TextInputType.name,
                inputAction: TextInputAction.done,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                label: "URL"),



          ],
        ),
      ),
      bottomNavigationBar:
      CommonViews().customButton(textButton: "Save", onTap: (){})

    );
  }
}





