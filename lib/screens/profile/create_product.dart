import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../../neumorph.dart';
import '../../theme.dart';

class CreateProduct extends StatefulWidget {
  final String storeId;

  CreateProduct({Key? key, required this.storeId}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
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

  String deliveryValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.08),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF1A9AFF),
              const Color(0xFF54FADC),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.050,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.w),
                      color: Colors.white,
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 16.w,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical:
                                MediaQuery.of(context).size.height * 0.015),
                        hintText: "Search Fenix",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: 15.w, color: Colors.grey.shade500),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(
                          Icons.qr_code_scanner,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Create Selling Post'),
          )),
          const Divider(thickness: 4, color: textColor),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                children: [
                  kSpacing,
                  title('Photos'),
                  kSpacing,
                  Row(
                    children: [
                      imageSelect(),
                      tinyHSpace(),
                      imageSelect(),
                      tinyHSpace(),
                      imageSelect(),
                      tinyHSpace(),
                      imageSelect(),
                    ],
                  ),
                  kSpacing,
                  title('Title of Product'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Name",
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title('Item Specifics'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Location",
                    textController: countryController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
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
                    hint: "Storage Category",
                    textController: colorController,
                  ),
                  kSpacing,
                  title('Category'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Category",
                    textController: categoryController,
                  ),
                  kSpacing,
                  title('Price'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Price",
                    textController: priceController,
                  ),
                  kSpacing,
                  title('Description'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Description",
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title('Shipping'),
                  kSpacing,
                  check('Yes, I can Deliver the item', 'Yes'),
                  tinySpace(),
                  check('No, I can\'t Deliver the item', 'No'),
                  verticalSpace(0.02),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _storeController.createNewProduct(
                            _userController.getToken(),
                            storeId: widget.storeId,
                            title: nameController.text,
                            discount: '',
                            plan: '',
                            deliveryAddress: '',
                            deliveryCity: '',
                            shippingCost: '',
                            capacity: '',
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
          ),
        ],
      ),
    );
  }

  Row check(title, subText) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            )),
        Expanded(
            child: Text(
          subText,
          style: const TextStyle(fontSize: 13),
        )),
        Container(
            decoration: depressNeumorph(),
            child: SizedBox(
              height: 23,
              width: 23,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.transparent, // Your color
                ),
                child: Checkbox(
                  value: deliveryValue == subText,
                  onChanged: (v) {
                    setState(() {
                      deliveryValue = subText;
                    });
                  },
                ),
              ),
            )),
      ],
    );
  }

  Container imageSelect() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: lightGrey),
          borderRadius: BorderRadius.circular(5)),
      child: const Padding(
        padding: EdgeInsets.all(25.0),
        child: Icon(Icons.photo_camera, color: lightGrey),
      ),
    );
  }

  Row title(String title) {
    return Row(
      children: [
        Image.asset(
          'assets/images/icons/check.png',
          height: 20,
        ),
        tinyH5Space(),
        Text(title),
      ],
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
