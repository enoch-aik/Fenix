import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key}) : super(key: key);

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
          title: SizedBox(
            height: 46.h,
            child: Image.asset(
              "assets/images/fenixWhite2.png",
              fit: BoxFit.fill,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2(
                const Color(0xFF46E0C4),
                const Color(0xFF59B5C0),
              ),
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
              gradient: gradient2(
                const Color(0xFF41F0D1),
                const Color(0xFF4A9A9E),
              ),
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
                  "Your account Information",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.black, size: 40.w,),
                                  tinyHSpace(),
                                  Text(firstNameController.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),),
                                  tinyH5Space(),
                                  Text(lastNameController.text,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),)
                                ],
                              ),

                              InkWell(
                                onTap: (){
                                  Get.to(() => EditProfile());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.w),
                                    border: Border.all(color: dark.withOpacity(0.5)),
                                  ),
                                  child: Text("Edit",
                                  style: TextStyle(
                                    fontSize: 14.w
                                  ),),
                                ),
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
                            enabled: false,
                            textController: userNameController,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                              hint: "Phone Number",
                              enabled: false,
                              textController: phoneController),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Address",
                            enabled: false,
                            textController: addressController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "City",
                            enabled: false,
                            textController: cityController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Country",
                            enabled: false,
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
