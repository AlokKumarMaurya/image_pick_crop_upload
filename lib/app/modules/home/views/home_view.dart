
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Original image"),
              controller.selectedImagePath!=""?Image.file(File(controller.selectedImagePath)):const SizedBox(),
            controller.selectedImageSize!=""?Text(controller.selectedImageSize):const SizedBox(),
            ElevatedButton(onPressed: ()=>controller.pickImage(ImageSource.camera), child:const Text("Camera")),
            ElevatedButton(onPressed: ()=>controller.pickImage(ImageSource.gallery), child:const Text("Gallery")),
            const Text("Cropped image"),
            controller.cropImagePath!=""?Image.file(File(controller.cropImagePath)):const SizedBox(),
            controller.cropImageSize!=""?Text(controller.cropImageSize):const SizedBox(),
            const Text("compressed image"),
            controller.compressedImagePath!=""?Image.file(File(controller.compressedImagePath)):const SizedBox(),
            controller.compressedImageSize!=""?Text(controller.compressedImageSize):const SizedBox(),
          ],
        ),
      )
    );
  }
}
