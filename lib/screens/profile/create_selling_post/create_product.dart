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
import '../../../helpers/categories.dart';
import '../../../helpers/image_picker.dart';
import '../../../neumorph.dart';
import '../../../theme.dart';
import 'create_apartment.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProduct extends StatefulWidget {
  final String storeId;
  String type;

  CreateProduct({Key? key, required this.storeId, this.type = ""})
      : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  PageController pageController = PageController();

  final UserController _userController = Get.find();

  final StoreController _storeController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final quantityController = TextEditingController();
  final storeController = TextEditingController();

  final priceController = TextEditingController();

  final nameController = TextEditingController();

  final sizeController = TextEditingController();

  final materialController = TextEditingController();

  final descriptionController = TextEditingController();

  final conditionController = TextEditingController();

  final categoryController = TextEditingController(text: "Electronics");
  final subcategoryController = TextEditingController();

  final colorController = TextEditingController();
  final capacityController = TextEditingController();

  final brandController = TextEditingController();
  final modelController = TextEditingController();

  final featuresController = TextEditingController();
  final deliveryLocationController = TextEditingController();

  final featureController = TextEditingController();
  final deliveryPriceController = TextEditingController();
  final discountController = TextEditingController();
  final planController = TextEditingController();
  final deliveryController = TextEditingController();

  String storeId = '';
  List<File> images = [];
  List<File> videos = [];
  String deliveryValue = '';
  bool selectDollar = false;
  File? _image;

  String store = '';
  List<dynamic> stores = [];
  List<String> storeIds = [];

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

  List<dynamic>? getStoreListNames() {
    for (var i = 0; i < _storeController.storeList.length; i++) {
      stores.add(_storeController.storeList[i]);
    }
    return stores;
  }

  List<String>? getStoreIds() {
    for (var i = 0; i < _storeController.storeList.length; i++) {
      storeIds.add(_storeController.storeList[i]['id']);
    }
    return storeIds;
  }

  @override
  void initState() {
    super.initState();
    getStoreListNames();
    // getStoreIds();
    storeId = stores[0]['id'];
    storeController.text = stores[0]['name'];
    categoryController.text = widget.type != "Other" ? "Electronics" : "";
  }

  pickList(List list, String title, {onSelect}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(children: [
                closeButton(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('$title',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)))),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(list.length, (i) {
                    var item = list[i];
                    return ListTile(
                        title: Text(item['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        onTap: () => onSelect(item));
                  }))),
                ),
              ]),
            ));
  }

  InkWell closeButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: width() * 0.13,
            height: 2.5,
            decoration: BoxDecoration(
                color: lightGrey, borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }

  pickBrand(List list, String title, {onSelect}) {
    print(list);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(children: [
                closeButton(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('Select $title',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)))),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(list.length, (i) {
                    var item = list[i];
                    return ListTile(
                        title: Text(item['brand'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        onTap: () => onSelect(item));
                  }))),
                ),
              ]),
            ));
  }

  pickModel(List list, String title, {onSelect}) {
    print(list);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(children: [
                closeButton(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('Select $title',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)))),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(list[0]['model'].length, (i) {
                    var item = list[0]['model'][i];
                    return ListTile(
                        title: Text(item,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        onTap: () => onSelect(item));
                  }))),
                ),
              ]),
            ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.storeId);

    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.1),
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
            child: Text(AppLocalizations.of(context)!.createSellingPost,
                style: TextStyle(fontWeight: FontWeight.w400)),
          )),
          const Divider(thickness: 4, color: textColor),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                children: [
                  kSpacing,
                  title(AppLocalizations.of(context)!.store),
                  smallText(AppLocalizations.of(context)!.storeSubText),
                  kSpacing,
                  // DropDownWidget(
                  //     list: stores,
                  //     store: store,
                  //     items: stores.map((String items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Text(items),
                  //       );
                  //     }).toList(),
                  //     onChanged: (val) {
                  //       var index = stores.indexOf(val!);
                  //       setState(() {
                  //         store = val;
                  //       });
                  //       storeId = storeIds[index];
                  //     }),
                  InkWell(
                    onTap: () {
                      pickList(stores, 'Store', onSelect: (v) {
                        Get.back();
                        setState(() {
                          storeController.text = v['name'];
                          storeId = v['id'];
                        });
                      });
                    },
                    child: TextFieldWidget(
                      hint: AppLocalizations.of(context)!.store,
                      enabled: false,
                      suffix: const Icon(Icons.expand_more),
                      textController: storeController,
                      validator: (value) => FieldValidator.validate(value!),
                    ),
                  ),
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
                  title(AppLocalizations.of(context)!.titleOfProduct),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.nameOfProduct,
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.itemSpecifics),

                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.condition,
                    textController: conditionController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.quantity,
                    textController: quantityController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.material,
                    textController: materialController,
                  ),

                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.size,
                    textController: sizeController,
                  ),

                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.feature,
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
                    hint: AppLocalizations.of(context)!.color,
                    textController: colorController,
                  ),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.storageCapacity,
                    textController: capacityController,
                  ),
                  // kSpacing,
                  // // title('Category'),
                  // // kSpacing,
                  // TextFieldWidget(
                  //   hint: "Category",
                  //   textController: categoryController,
                  //   enabled: false,
                  // ),

                  kSpacing,
                  InkWell(
                    onTap: () {
                      pickList(Category().allCategories, 'Category',
                          onSelect: (v) {
                        Get.back();

                        setState(() {
                          categoryController.text = v['name'];
                          subcategoryController.text = '';
                          modelController.text = '';
                          brandController.text = '';
                        });
                      });
                    },
                    child: TextFieldWidget(
                      hint: "Category",
                      textController: categoryController,
                      enabled: false,
                      suffix: const Icon(Icons.expand_more),
                    ),
                  ),

                  kSpacing,
                  InkWell(
                    onTap: () {
                      if (categoryController.text.isNotEmpty) {
                        pickList(
                            categoryController.text == 'Electronics'
                                ? Category().electronics
                                : categoryController.text == 'Clothing'
                                    ? Category().clothing
                                    : categoryController.text == 'Property'
                                        ? Category().propertyCategory
                                        : categoryController.text == 'Car'
                                            ? Category().carCategories
                                            : categoryController.text ==
                                                    'Health Care'
                                                ? Category().healthCare
                                                : categoryController.text ==
                                                        'Food Market'
                                                    ? Category().foodMarket
                                                    : categoryController.text ==
                                                            'Kids'
                                                        ? Category().kids
                                                        : categoryController
                                                                    .text ==
                                                                'Tools'
                                                            ? Category().tools
                                                            : [],
                            'Sub-Category', onSelect: (v) {
                          Get.back();

                          setState(() {
                            subcategoryController.text = v['name'];
                            modelController.text = '';
                            brandController.text = '';

                          });
                        });
                      }
                    },
                    child: TextFieldWidget(
                      hint: AppLocalizations.of(context)!.subCategory,
                      textController: subcategoryController,
                      enabled: false,
                      suffix: const Icon(Icons.expand_more),
                    ),
                  ),
                  kSpacing,
                  InkWell(
                    onTap: () {
                      if (subcategoryController.text.contains('Cellphones')) {
                        // Category().electronics[1]['cell phones']
                        pickBrand(Category().electronics[1]['cell phones'],
                            'Phone Brands', onSelect: (v) {
                          setState(() {
                            brandController.text = v['brand'];
                            modelController.text = '';
                          });
                          Get.back();
                        });
                      }
                    },
                    child: TextFieldWidget(
                      hint: AppLocalizations.of(context)!.brand,
                      enabled:
                          !subcategoryController.text.contains('Cellphones'),
                      textController: brandController,
                      validator: (value) => FieldValidator.validate(value!),
                    ),
                  ),
                  if (subcategoryController.text.contains('Cellphones'))
                    kSpacing,
                  if (subcategoryController.text.contains('Cellphones'))
                    InkWell(
                      onTap: (){
                        pickModel(
                            Category().electronics[1]
                            ['cell phones'].where((e)=>e['brand']==brandController.text).toList(),
                            'Brand', onSelect: (v) {
                          Get.back();
                          setState(() {
                            modelController.text = v;
                          });
                        });
                      },
                      child: TextFieldWidget(
                        hint: AppLocalizations.of(context)!.model,
                        enabled: false,
                        textController: modelController,
                      ),
                    ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.description),
                  kSpacing,
                  TextFieldWidget(
                    hint: AppLocalizations.of(context)!.description,
                    maxLine: 5,
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.price),
                  kSpacing,
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: AppLocalizations.of(context)!.price,
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
                  title(AppLocalizations.of(context)!.discount),
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
                            hint: AppLocalizations.of(context)!.discount,
                            textController: discountController),
                      ),
                    ],
                  ),
                  kSpacing,
                  title(AppLocalizations.of(context)!.shipping),
                  kSpacing,
                  check('${AppLocalizations.of(context)!.canDeliver}', 'Yes'),
                  tinySpace(),
                  check('${AppLocalizations.of(context)!.canNotDeliver}', 'No'),
                  kSpacing,

                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            hint: AppLocalizations.of(context)!.deliveryPrice,
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
                      hint: AppLocalizations.of(context)!.deliveryDetails,
                      textController: deliveryController),
                  kSpacing,

                  TextFieldWidget(
                      hint: AppLocalizations.of(context)!.deliveryLocation,
                      textController: deliveryLocationController),

                  verticalSpace(0.02),
                  Center(
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _storeController.createNewProduct(
                                _userController.getToken(),
                                storeId: _storeController.getDefaultStoreId(),
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
                                subCategory: subcategoryController.text,
                                condition: conditionController.text,
                                brand: brandController.text,
                                coordinate: "12.345678, -98.765432",
                                features: featuresController.text,
                                color: colorController.text,
                                model: modelController.text,
                                description: descriptionController.text,
                                media: images);
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

  Widget imageSelect({icon, onTap, image}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: light),
            borderRadius: BorderRadius.circular(10)),
        child: image != null
            ? Image.file(
                image,
                width: 82,
                height: 82,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.all(30.0),
                child: Icon(icon ?? Icons.photo_camera, color: lightGrey),
              ),
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
