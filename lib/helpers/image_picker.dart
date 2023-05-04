import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



RxList<File>? images = <File>[].obs;
Rx<File>? image = File("").obs;
RxDouble imageHeight = 0.0.obs;

RxString path = 'assets/images/profile.png'.obs;

RxBool visibility = false.obs;

final picker = ImagePicker();


Future getImageFromGallery(ImageSource source) async {
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    image = File(pickedFile.path).obs;
    images!.add(image!.value);
    imageHeight.value = 0.2;
    path.value= image!.value.path;
    visibility = true.obs;

    Get.back();


  } else {
    print('No image selected.');
  }
}



// Future<String> uploadFile(File image) async
// {
//   String downloadURL;
//   String postId=DateTime.now().millisecondsSinceEpoch.toString();
//   Reference ref = FirebaseStorage.instance.ref().child("images").child("post_$postId.jpg");
//   await ref.putFile(image);
//   downloadURL = await ref.getDownloadURL();
//   return downloadURL;
// }


Future getImageFromCamera(ImageSource source) async {
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    image = File(pickedFile.path).obs;
    imageHeight.value = 0.2;
    path.value= image!.value.path;
    visibility = true.obs;
    Get.back();


  } else {
    print('No image selected.');
  }
}