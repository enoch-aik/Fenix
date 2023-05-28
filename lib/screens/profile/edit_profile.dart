import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
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
    }
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/fenixmall_white.png",
                color: Colors.white,
                height: height() * 0.075,
              ),
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
                          Column(
                            children: [
                              Icon(Icons.person, size: 40.w,),
                              tiny5Space(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Choose a photo",
                                  style: TextStyle(
                                    fontSize: 13.w,
                                    color: dark.withOpacity(0.3),
                                  ),),
                                  tinyHSpace(),
                                  Icon(Icons.edit, size: 13.w, color: dark.withOpacity(0.3),)
                                ],
                              )
                            ],
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
                              gender(context, Icons.male, 'Male'),
                              smallHSpace(),
                              gender(context, Icons.female, 'Female'),
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
                                      gender: _userController.gender.value,
                                      address: addressController.text,
                                      country: countryController.text,
                                      city: cityController.text);
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

  Widget gender(BuildContext context, icon, title) {
    print(_userController.gender.value);

    return Expanded(
      child: InkWell(
        onTap: () {
          _userController.gender(title);
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.w),
              color: (_userController.gender.value == title ||
                      (_userController.getUser() != null &&
                          _userController.getUser()!.gender == title))
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
                          color: (_userController.gender.value == title ||
                                  (_userController.getUser() != null &&
                                      _userController.getUser()!.gender ==
                                          title))
                              ? Colors.black
                              : Colors.grey.shade400,
                        ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_userController.gender.value == title ||
                                (_userController.getUser() != null &&
                                    _userController.getUser()!.gender == title))
                            ? light.withOpacity(0.5)
                            : Colors.transparent),
                    child: Icon(
                      icon,
                      color: (_userController.gender.value == title ||
                              (_userController.getUser() != null &&
                                  _userController.getUser()!.gender == title))
                          ? kTextBlackColor
                          : Colors.blueGrey,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
