import 'dart:io';

import 'package:image_picker/image_picker.dart';

openGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery, maxHeight: 612, maxWidth: 816);

  if (pickedFile != null) {
    File file = File(pickedFile.path);
    return file;
  }

  return null;
}

openVideoGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile = await imagePicker.pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    File file = File(pickedFile.path);
    return file;
  }

  return null;
}

openVideoCamera() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile = await imagePicker.pickVideo(
    source: ImageSource.camera,
  );
  if (pickedFile != null) {
    File file = File(pickedFile.path);
    return file;
  }

  return null;
}

openCamera() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 612,
      maxWidth: 816);
  if (pickedFile != null) {
    File file = File(pickedFile.path);
    return file;
  }

  return null;
}
