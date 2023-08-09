import 'package:fenix/const.dart';
import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/dialogs.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller.dart';
import '../../onboarding/constants.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.find();
  final AccountController accountController = Get.find();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/fenixmall_white.png",
              color: white,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
                const SizedBox(),
              ],
            ),
          ),
          Expanded(
              child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalSpace(0.05),
                    TextFieldWidget(
                      hint: "Old Password",
                      textController: oldPassController,
                      validator: (value) => FieldValidator.validate(value!),
                    ),
                    kSpacing,
                    TextFieldWidget(
                      hint: "New Password",
                      textController: newPassController,
                      validator: (value) => PasswordValidator.validate(value!),
                    ),
                    kSpacing,
                    TextFieldWidget(
                        hint: "Confirm Password",
                        textController: confirmPassController,
                        validator: (value) {
                          if (value != newPassController.text) {
                            return "Password does not match";
                          }
                          return null;
                        }),
                    verticalSpace(0.3),
                    DefaultButton(
                      title: 'Save',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          CustomDialogs.showNoticeDialog(
                              message:
                                  "Remember this new password on your next login.\nAre you sure you want to continue?",
                              closeText: 'Cancel',
                              okText: 'Confirm',
                              onClick: () {
                                accountController.changePassword(
                                    _userController.getToken(),
                                    oldPassController.text,
                                    newPassController.text);
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  InkWell accountContainer(title, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration:
            depressNeumorph().copyWith(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              )),
              const Icon(Icons.arrow_forward, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
