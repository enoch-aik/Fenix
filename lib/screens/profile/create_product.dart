import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snackBar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../../theme.dart';

class CreateProduct extends StatelessWidget {
  final String storeId;

  CreateProduct({Key? key, required this.storeId}) : super(key: key);

  PageController pageController = PageController();
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final countryController = TextEditingController();
  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final materialController = TextEditingController();
  final descriptionController = TextEditingController();
  final conditionController = TextEditingController();
  final categoryController = TextEditingController();
  final colorController = TextEditingController();
  final brandController = TextEditingController();
  final featuresController = TextEditingController();
  final featureController = TextEditingController();

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
                  "Create Product",
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
                            textController: nameController,
                            validator: (value) =>
                                FieldValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Location",
                            textController: countryController,
                            validator: (value) =>
                                FieldValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Category",
                            textController: categoryController,
                          ),  kSpacing,
                          TextFieldWidget(
                            hint: "Feature",
                            textController: featuresController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Quantity",
                            textController: quantityController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Price",
                            textController: priceController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Size",
                            textController: sizeController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Condition",
                            textController: conditionController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Material",
                            textController: materialController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Color",
                            textController: colorController,
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Description",
                            textController: descriptionController,
                          ),
                          verticalSpace(0.02),
                          InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _storeController.createNewProduct(
                                    _userController.getToken(),
                                    storeId: storeId,
                                    title: nameController.text,
                                    address: countryController.text,
                                    quantity: quantityController.text,
                                    price: priceController.text,
                                    size: sizeController.text,
                                    material: materialController.text,
                                    category: categoryController.text,
                                    condition: conditionController.text,
                                    brand: brandController.text,
                                    coordinate: "12.345678, -98.765432",
                                    features: featuresController.text,
                                    color: colorController.text,
                                    description: descriptionController.text,
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
