import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  //var for original selected image
  var selectedImagePath = "";
  var selectedImageSize = "";

  //var for crop images
  var cropImagePath = "";
  var cropImageSize = "";

  //var for compressed images
  var compressedImagePath = "";
  var compressedImageSize = "";

  void pickImage(ImageSource imageSource) async {
    final picker = await ImagePicker().getImage(source: imageSource);
    if (picker != null) {
      selectedImagePath = picker.path;
      selectedImageSize =
          "${(((File(picker.path).lengthSync()) / 1024) / 1024).toStringAsFixed(2)}Mb";
      cropImage();
    } else {
      Get.snackbar("Error", "no image selected");
    }
    update();
  }

  void cropImage() async {
    final cropImage = await ImageCropper().cropImage(
        sourcePath: selectedImagePath,
        maxWidth: 512,
        maxHeight: 512,
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: CropStyle.rectangle,
        compressQuality: 80);
    cropImagePath=cropImage!.path;
    cropImageSize=((((File(cropImagePath).lengthSync())/1024)/1024).toStringAsFixed(2));
   compressImage();
  }


  void compressImage()async{
    final dir=Directory.systemTemp;
    final targetPath="${dir.absolute.path}/temp.jpg";
    var compressedFile=await FlutterImageCompress.compressAndGetFile(cropImagePath, targetPath,quality: 90);
    compressedImagePath=compressedFile!.path;
    compressedImageSize="${(((File(compressedImagePath).lengthSync())/1024)/1021).toStringAsFixed(2)}Mb";
  }
}
