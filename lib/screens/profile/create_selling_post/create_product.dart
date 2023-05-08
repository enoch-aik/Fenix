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

import '../../../controller/store_controller.dart';
import '../../../helpers/image_picker.dart';
import '../../../neumorph.dart';
import '../../../theme.dart';

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

  final nameController = TextEditingController();

  final sizeController = TextEditingController();

  final materialController = TextEditingController();

  final descriptionController = TextEditingController();

  final conditionController = TextEditingController();

  final categoryController = TextEditingController();

  final colorController = TextEditingController();
  final capacityController = TextEditingController();

  final brandController = TextEditingController();

  final featuresController = TextEditingController();
  final deliveryLocationController = TextEditingController();

  final featureController = TextEditingController();
  final deliveryPriceController = TextEditingController();
  final discountController = TextEditingController();
  final planController = TextEditingController();
  final deliveryController = TextEditingController();

  String deliveryValue = '';
  bool selectDollar = false;
  File? _image;

  Future<dynamic> showImagePickers({isPhoto = true}) {
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

                                  var selectedImage = isPhoto
                                      ? await openCamera()
                                      : await openVideoCamera();
                                  if (selectedImage != null) {
                                    setState(() {
                                      _image = selectedImage;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Take ${isPhoto ? 'Photo' : 'Video'} from camera',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    const Padding(
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

                                  var selectedImage = isPhoto
                                      ? await openGallery()
                                      : await openVideoGallery();
                                  if (selectedImage != null) {
                                    setState(() {
                                      _image = selectedImage;
                                    });
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                          'Take ${isPhoto ? 'Photo' : 'Video'} from gallery',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    const Padding(
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

  @override
  Widget build(BuildContext context) {
    print(widget.storeId);

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
            child: Text('Create Selling Post',style: TextStyle(fontWeight: FontWeight.w400)),
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
                      imageSelect(icon: Icons.videocam),
                      tinyHSpace(),
                      imageSelect(icon: Icons.add),
                      tinyHSpace(),
                      imageSelect(),
                    ],
                  ),
                  kSpacing,
                  title('Title of Product'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Name of product",
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title('Item Specifics'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Condition",
                    textController: conditionController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Quantity",
                    textController: quantityController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Material",
                    textController: materialController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Brand",
                    textController: brandController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Size",
                    textController: sizeController,
                  ),

                  kSpacing,
                  TextFieldWidget(
                    hint: "Feature",
                    textController: featuresController,
                  ),
                  // kSpacing,
                  // TextFieldWidget(
                  //   hint: "Location",
                  //   textController: countryController,
                  //   validator: (value) => FieldValidator.validate(value!),
                  // ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Color",
                    textController: colorController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Storage Capacity",
                    textController: capacityController,
                  ),
                  kSpacing,
                  // title('Category'),
                  // kSpacing,
                  TextFieldWidget(
                    hint: "Category",
                    textController: categoryController,
                  ),

                  kSpacing,
                  title('Description'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Description",
                    maxLine: 5,
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title('Price'),
                  kSpacing,
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Price",
                            textController: priceController),
                      ),
                      smallHSpace(),
                      const Text(
                        'so\'m',
                        style: TextStyle(fontSize: 13),
                      ),
                      tinyH5Space(),
                      checkBox(),
                    ],
                  ),
                  kSpacing,
                  title('Discount Option'),
                  kSpacing,

                  Row(
                    children: [
                      discount(),
                      tinyH5Space(),
                      discount(),
                      tinyH5Space(),
                      discount(),
                      smallHSpace(),
                      Expanded(
                        child: TextFieldWidget(
                            hint: "Discount",
                            textController: discountController),
                      ),
                    ],
                  ),
                  kSpacing,
                  title('Shipping'),
                  kSpacing,
                  check('Yes, I can Deliver the item', 'Yes'),
                  tinySpace(),
                  check('No, I can\'t Deliver the item', 'No'),
                  kSpacing,

                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            hint: "Delivery Price",
                            textController: deliveryPriceController),
                      ),
                      smallHSpace(),
                      const Text(
                        'so\'m',

                        style: TextStyle(fontSize: 13),
                      ),
                      tinyH5Space(),
                      checkBox(),
                    ],
                  ),
                  kSpacing,

                  TextFieldWidget(
                      hint: "Delivery Details",
                      textController: deliveryController),
                  kSpacing,

                  TextFieldWidget(
                      hint: "Delivery Location",
                      textController: deliveryLocationController),

                  verticalSpace(0.02),
                  Center(
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _storeController.createNewProduct(
                              _userController.getToken(),
                              storeId: widget.storeId,
                              title: nameController.text,
                              discount: discountController.text,
                              plan: 'Basic',
                              deliveryAddress: deliveryController.text,
                              deliveryCity: deliveryLocationController.text,
                              shippingCost: deliveryPriceController.text,
                              capacity: capacityController.text,
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
                  ),
                  verticalSpace(0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container checkBox() {
    return Container(
        decoration: depressNeumorph(),
        child: SizedBox(
          height: 23,
          width: 23,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.transparent, // Your color
            ),
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: selectDollar,
              onChanged: (v) {
                setState(() {
                  selectDollar = v!;
                });
              },
            ),
          ),
        ));
  }

  Container discount() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE4EFF9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFf334669), width: 0.1),
        gradient: LinearGradient(
            colors: [
              Colors.white,
              const Color(0xFFDBE6F2).withOpacity(0.2),
              const Color(0xFF8F9FAE).withOpacity(0.2),
            ],
            stops: const [
              0.0,
              0.5,
              1.0
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            tileMode: TileMode.repeated),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(1, 0), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: const Text(
        '10%',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
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

  Container imageSelect({icon}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: light),
          borderRadius: BorderRadius.circular(10)),
      child:  Padding(
        padding: EdgeInsets.all(30.0),
        child: Icon(icon??Icons.photo_camera, color: lightGrey),
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
