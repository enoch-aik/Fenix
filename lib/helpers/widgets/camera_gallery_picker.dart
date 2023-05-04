import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../image_picker.dart';

class CameraGalleryPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Text(
                'Pick an Image',
                style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: InkWell(
              onTap: () {
                getImageFromCamera(ImageSource.camera);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black87,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(fontSize: 18.w),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: InkWell(
              onTap: () {
                getImageFromGallery(ImageSource.gallery);
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.black87,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(fontSize: 18.w),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}