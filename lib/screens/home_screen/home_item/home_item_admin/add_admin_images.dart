// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAdminImages extends StatefulWidget {
  const AddAdminImages({Key? key}) : super(key: key);

  @override
  State<AddAdminImages> createState() => _AddAdminImagesState();
}

class _AddAdminImagesState extends State<AddAdminImages> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFiles = [];

  openImages() async {
    try {
      var pickedFiles = await imagePicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedFiles != null) {
        imageFiles = pickedFiles;
        setState(() {});
      } else {
        if (kDebugMode) {
          print("No image is selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while picking file.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //open button ----------------
            ElevatedButton(
                onPressed: () {
                  openImages();
                },
                child: const Text("Open Images")),
            const Divider (
              thickness: 2,
            ),
            const Text("Picked Files:"),
            const Divider(
              thickness: 2,
            ),

            imageFiles != null
                ? Wrap(
              children: imageFiles.map((imageOne) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.file(File(imageOne.path)),
                );
              }).toList(),
            )
                : Container()
          ],
        ),
      ),


    );
  }
}
