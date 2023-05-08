import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/store_controller.dart';
import '../../../theme.dart';

class CreateStore extends StatelessWidget {
  CreateStore({Key? key}) : super(key: key);

  PageController pageController = PageController();
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "Create Store",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.w,
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
                          TextFieldWidget(
                            hint: "Name",
                            textController:nameController,
                            validator: (value) =>
                                FieldValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Description",
                            textController:descriptionController,
                            validator: (value) =>
                                FieldValidator.validate(value!),
                          ),

                          kSpacing,
                          TextFieldWidget(
                            hint: "Address",
                            textController: addressController,
                          ),


                          verticalSpace(0.4),
                          InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _storeController.createNewStore(
                                      _userController.getToken(),
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      location: addressController.text,
                                     );
                                } else {
                                  CustomSnackBar.failedSnackBar('Error',
                                      'Ensure that all required fields are filled');
                                }
                              },
                              child: ButtonWidget(title: "Next")),
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
