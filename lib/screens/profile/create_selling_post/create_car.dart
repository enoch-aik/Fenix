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
import 'create_apartment.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateCar extends StatefulWidget {
  final String storeId;

  CreateCar({Key? key, required this.storeId}) : super(key: key);

  @override
  State<CreateCar> createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateCar> {
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

  final categoryController = TextEditingController(text: "Cars");

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
  final mileageController = TextEditingController();
  final detailController = TextEditingController();
  final keyController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final seatController = TextEditingController();
  List amenities = [];
  List<File> images = [];
  List<File> videos = [];
  String deliveryValue = '';
  String hadAccident = '';
  String firstOwner = '';
  bool selectDollar = false;

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
                                      isPhoto
                                          ? images.add(selectedImage)
                                          : videos.add(selectedImage);
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
                                      isPhoto
                                          ? images.add(selectedImage)
                                          : videos.add(selectedImage);
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
            height() * 0.1),
        child: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  backArrow(),
                  Expanded(
                    child: Container(
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
                          hintText: AppLocalizations.of(context)!.searchFenix,
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
           Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.createCarListing),
          )),
          const Divider(thickness: 4, color: textColor),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                children: [
                  kSpacing,
                  title(AppLocalizations.of(context)!.photos),
                  kSpacing,
                  images.isNotEmpty || videos.isNotEmpty
                      ? Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: List.generate(
                            images.length + 2,
                            (index) => index == images.length
                                ? imageSelect(
                                    onTap: () => showImagePickers(),
                                  )
                                : index == images.length + 1
                                    ? imageSelect(
                                        icon: Icons.video_call,
                                        onTap: () =>
                                            showImagePickers(isPhoto: false),
                                      )
                                    : imageSelect(
                                        onTap: () => showImagePickers(),
                                        image: images[index]),
                          ),
                        )
                      : Row(
                          children: [
                            imageSelect(
                              onTap: () => showImagePickers(),
                            ),
                            tinyHSpace(),
                            imageSelect(
                              icon: Icons.videocam_rounded,
                              onTap: () => showImagePickers(isPhoto: false),
                            ),
                            tinyHSpace(),
                            imageSelect(icon: Icons.add),
                            tinyHSpace(),
                            // imageSelect(icon: Icons.add),
                          ],
                        ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.title),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.nameOfProduct,
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.itemSpecifics),
                  kSpacing,
                  textTitle('${AppLocalizations.of(context)!.carBrand}:'),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.brand,
                    textController: brandController,
                  ),
                  kSpacing,
                  textTitle('${AppLocalizations.of(context)!.carModel}:'),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.model,
                    textController: modelController,
                  ),
                  kSpacing,
                  textTitle('${AppLocalizations.of(context)!.carYear}:'),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.year,
                    textController: yearController,
                  ),
                  kSpacing,
                  textTitle('${AppLocalizations.of(context)!.color}:'),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.color,
                    textController: colorController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  textTitle('${AppLocalizations.of(context)!.carMileage}:'),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.mileage,
                    textController: mileageController,
                  ),
                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.howManyKeys),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.keys,
                    textController: keyController,
                  ),
                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.howManySeats),
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.seats,
                    textController: seatController,
                  ),

                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.anyAccident),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                hint: AppLocalizations.of(context)!.yes,
                                enabled: false,
                                textController:
                                    TextEditingController(text: 'Yes'),
                              ),
                            ),
                            tinyHSpace(),
                            checkBox(
                              hadAccident == 'Yes',
                              onChanged: (v) {
                                setState(() {
                                  hadAccident = "Yes";
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      smallHSpace(),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                hint: AppLocalizations.of(context)!.no,
                                enabled: false,
                                textController:
                                    TextEditingController(text: 'No'),
                              ),
                            ),
                            tinyHSpace(),
                            checkBox(
                              hadAccident == 'No',
                              onChanged: (v) {
                                setState(() {
                                  hadAccident = "No";
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  kSpacing,
                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.firstOwner),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                hint: AppLocalizations.of(context)!.yes,
                                enabled: false,
                                textController:
                                    TextEditingController(text: 'Yes'),
                              ),
                            ),
                            tinyHSpace(),
                            checkBox(
                              firstOwner == 'Yes',
                              onChanged: (v) {
                                setState(() {
                                  firstOwner = "Yes";
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      smallHSpace(),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                hint: AppLocalizations.of(context)!.no,
                                enabled: false,
                                textController:
                                    TextEditingController(text: 'No'),
                              ),
                            ),
                            tinyHSpace(),
                            checkBox(
                              firstOwner == 'No',
                              onChanged: (v) {
                                setState(() {
                                  firstOwner = "No";
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  kSpacing,
                  // title('Category'),
                  // kSpacing,
                  //
                  // TextFieldWidget(
                  //   hint: "Category",
                  //   textController: categoryController,
                  //   suffixIcon: const Icon(Icons.expand_more),
                  // ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.description),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.description,
                    maxLine: 6,
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.price),
                  kSpacing,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: AppLocalizations.of(context)!.price,
                            textController: priceController),
                      ),
                      mediumHSpace(),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'So\'m',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                tinyH5Space(),
                                checkBox(
                                  !selectDollar,
                                  onChanged: (v) {
                                    setState(() {
                                      selectDollar = !v!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            tiny5Space(),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Dollar \$',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                tinyH5Space(),
                                checkBox(
                                  selectDollar,
                                  onChanged: (v) {
                                    setState(() {
                                      selectDollar = v!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  // kSpacing,
                  // title('Discount Option'),
                  // kSpacing,
                  // Row(
                  //   children: [
                  //     discount(),
                  //     tinyH5Space(),
                  //     discount(),
                  //     tinyH5Space(),
                  //     discount(),
                  //     smallHSpace(),
                  //     Expanded(
                  //       child: TextFieldWidget(
                  //           hint: "Discount",
                  //           textController: discountController),
                  //     ),
                  //   ],
                  // ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.shipping),
                  kSpacing,
                  check(AppLocalizations.of(context)!.canDeliver, AppLocalizations.of(context)!.yes),
                  tinySpace(),
                  check(AppLocalizations.of(context)!.canNotDeliver, AppLocalizations.of(context)!.no),
                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.deliveryPrice),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: AppLocalizations.of(context)!.deliveryPrice,
                            textController: deliveryPriceController),
                      ),
                      mediumHSpace(),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'So\'m',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                tinyH5Space(),
                                checkBox(
                                  !selectDollar,
                                  onChanged: (v) {
                                    setState(() {
                                      selectDollar = !v!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            tiny5Space(),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Dollar \$',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                tinyH5Space(),
                                checkBox(
                                  selectDollar,
                                  onChanged: (v) {
                                    setState(() {
                                      selectDollar = v!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  kSpacing, textTitle(AppLocalizations.of(context)!.deliveryDetails),

                  TextFieldWidget(
                      hint: AppLocalizations.of(context)!.deliveryDetails,
                      textController: detailController),
                  kSpacing, textTitle(AppLocalizations.of(context)!.deliveryLocation),
                  TextFieldWidget(
                      hint: AppLocalizations.of(context)!.deliveryLocation,
                      textController: deliveryLocationController),

                  kSpacing,
                  textTitle(AppLocalizations.of(context)!.amenities),
                  tinySpace(),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 5,
                    runSpacing: 8,
                    children: [
                      amenitiesButton(
                          AppLocalizations.of(context)!.cdMp3
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.bluetooth,
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.usbFlash,
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.usbC,
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.heater,
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.seatHeater,
                      ),
                      amenitiesButton(
                        AppLocalizations.of(context)!.autoTms,
                      ),

                    ],
                  ),
                  verticalSpace(0.02),
                  Center(
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _storeController.createNewVehicle(
                              _userController.getToken(),
                              storeId: widget.storeId,
                              title: nameController.text,
                              amenities: amenities,
                              plan: 'Loggie',
                              mileage: mileageController.text,
                              model: modelController.text,
                              deliveryAddress: deliveryLocationController.text,
                              price: priceController.text,
                              shippingPrice: deliveryPriceController.text,
                              // category: categoryController.text,
                              category: 'Cars',
                              brand: brandController.text,
                              color: colorController.text,
                              description: descriptionController.text,
                              previousAccident: hadAccident == 'Yes',
                              firstOwner: firstOwner == 'Yes',
                              year: yearController.text,
                              seats: seatController.text,
                              key: keyController.text,
                              detail: detailController.text,
                              media: images,
                            );
                          } else {
                            CustomSnackBar.failedSnackBar('Error',
                                'Ensure that all required fields are filled');
                          }
                        },
                        child: ButtonWidget(title: AppLocalizations.of(context)!.next)),
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

  InkWell amenitiesButton( title) {
    return InkWell(
      onTap: () {
        setState(() {
          if (amenities.contains(title)) {
            amenities.remove(title);
          } else {
            amenities.add(title);
          }
        });
      },
      child: Row(
        children: [
          Container(
            width: width()*0.45,
              decoration: depressNeumorph(),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(title,softWrap: false,overflow: TextOverflow.clip,)

              // Icon(icon, color: amenities.contains(title) ? white : black),
              ),
          checkBox(amenities.contains(title), onChanged: (v) {
            setState(() {
              if (amenities.contains(title)) {
                amenities.remove(title);
              } else {
                amenities.add(title);
              }
            });
          })
        ],
      ),
    );
  }

  Text textTitle(text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  Container checkBox(value, {required void Function(bool?)? onChanged}) {
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
                value: value,
                onChanged: onChanged),
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
