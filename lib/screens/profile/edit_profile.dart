import 'dart:io';

import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/image_picker.dart';
import '../../theme.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PageController pageController = PageController();

  final UserController _userController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  final cityController = TextEditingController();

  final countryController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();
  File? _image;
  String profileImage = '';
  String token = '';
  String gender = '';

  @override
  initState() {
    token = _userController.getToken();
    getUser();
    super.initState();
  }

  getUser() {
    var user = _userController.getUser();
    print('user - ${_userController.getUser()}');
    if (user != null) {
      firstNameController.text = user.firstName.toString();
      lastNameController.text = user.lastName.toString();
      emailController.text = user.email.toString();
      userNameController.text = user.username.toString();
      addressController.text = user.address.toString();
      cityController.text = user.city.toString();
      phoneController.text = user.mobileNumber.toString();
      countryController.text = user.country.toString();
      gender = user.gender.toString();
      profileImage = user.profileImage.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/fenixmall_white.png",
              color: Colors.white,
              height: height() * 0.075,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          )),
      body: Column(
        children: [
          Container(
            height: 50.w,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 20.w),
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          kSpacing,
                          InkWell(
                            onTap: showImagePickers,
                            child: Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: grey),
                                      image: _image != null
                                          ? DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: FileImage(_image!))
                                          : profileImage != '' &&
                                                  profileImage != 'null'
                                              ? DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: NetworkImage(
                                                      profileImage))
                                              : const DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      'assets/images/fenixlogobird.png'))),
                                ),
                                tiny5Space(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Choose a photo",
                                      style: TextStyle(
                                        fontSize: 13.w,
                                        color: dark.withOpacity(0.3),
                                      ),
                                    ),
                                    tinyHSpace(),
                                    Icon(
                                      Icons.edit,
                                      size: 13.w,
                                      color: dark.withOpacity(0.3),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "First Name",
                            enabled: false,
                            textController: firstNameController,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Last Name",
                            enabled: false,
                            textController: lastNameController,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Email",
                            enabled: false,
                            textController: emailController,
                            validator: (value) =>
                                EmailValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Username",
                            textController: userNameController,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                              hint: "Phone Number",
                              keyboardType: TextInputType.number,
                              textController: phoneController),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Address",
                            textController: addressController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "City",
                            textController: cityController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Country",
                            textController: countryController,
                          ),
                          kSpacing,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectGender(context, Icons.male, 'Male'),
                              smallHSpace(),
                              selectGender(context, Icons.female, 'Female'),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _userController.updateProfile(
                                      _userController.getToken(),
                                      username: userNameController.text,
                                      phoneNumber: phoneController.text,
                                      gender: gender,
                                      address: addressController.text,
                                      country: countryController.text,
                                      city: cityController.text);
                                  if (_image != null) {
                                    _userController.uploadProfilePic(
                                        token: _userController.getToken(),
                                        media: _image);
                                  }
                                } else {
                                  CustomSnackBar.failedSnackBar('Error',
                                      'Ensure that all required fields are filled');
                                }
                              },
                              child: ButtonWidget(title: "Save Information")),
                          verticalSpace(0.04),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showImagePickers() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: height() * 0.32,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Get.back();
                                  var selectedImage = await openCamera();
                                  if (selectedImage != null) {
                                    setState(() {
                                      _image = selectedImage;
                                    });
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('Take Photo from camera',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Get.back();

                                  var selectedImage = await openGallery();
                                  if (selectedImage != null) {
                                    setState(() {
                                      _image = selectedImage;
                                    });
                                  }
                                },
                                child: const Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('Take Photo from gallery',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.collections,
                                        size: 25,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget selectGender(BuildContext context, icon, title) {

    return Expanded(
      child: InkWell(
        onTap: () {
      setState(() {
        gender = title;
      });
        },
        child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.w),
              color:
                gender==title
                  ? const Color(0xFFE4F0FA).withOpacity(0.8)
                  : const Color(0xFFE4F0FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  spreadRadius: -3,
                  blurRadius: 3,
                  offset: const Offset(3, 6), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15.w,
                          color:
                          gender == title
                              ? Colors.black
                              : Colors.grey.shade400,
                        ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        gender == title
                            ? light.withOpacity(0.5)
                            : Colors.transparent),
                    child: Icon(
                      icon,
                      color:                         gender == title

                          ? kTextBlackColor
                          : Colors.blueGrey,
                    )),
              ],
            ),
          ),

      ),
    );
  }
}

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
