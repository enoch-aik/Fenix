import 'dart:io';

import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/store_controller.dart';
import '../../../helpers/image_picker.dart';
import '../../../neumorph.dart';
import '../../../theme.dart';

class CreateApartment extends StatefulWidget {
  final String storeId;

  CreateApartment({Key? key, required this.storeId}) : super(key: key);

  @override
  State<CreateApartment> createState() => _CreateApartmentState();
}

class _CreateApartmentState extends State<CreateApartment> {
  PageController pageController = PageController();

  final UserController _userController = Get.find();

  final StoreController _storeController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final nightController = TextEditingController();
  final weekController = TextEditingController();
  final monthController = TextEditingController();

  String toilet = '';
  String bathroom = '';
  String bedroom = '';
  String bed = '';
  String shower = '';
  String floor = '';
  String rentType = '';
  String houseNumber = '';
  String footage = '';
  String square = '';
  String occupant = '';
  String startDate = '';
  String start = '';
  String startTime = '';
  String startDay = '';
  String endDate = '';
  String endTime = '';
  String endDay = '';
  String end = '';
  bool selectDollar = false;
  String checkin = '';
  String offer = '';
  String smoke = '';
  String pet = '';
  List amenities = [];
  List<File> images = [];
  List<File> videos = [];

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

  Future selectDate() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 4, DateTime.now().day));

    // return '';
  }

  Future selectTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
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
            child: Text(
              'Sell& Rent House or Apartment',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
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
                  smallText('Please select photos or video'),
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
                                onTap: () => showImagePickers(),),
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
                  const Divider(color: light, thickness: 3),
                  kSpacing,
                  title('Title of Property'),
                  smallText('Please enter the name of the property'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Name of property",
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title('House Specifics'),
                  kSpacing,
                  subText('How many Bedrooms'),
                  smallText('Please select how many bedroom is your property'),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('Bedroom 1', Icons.hotel_outlined, 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 2', Icons.hotel_outlined, 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 3', Icons.hotel_outlined, 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 4', Icons.hotel_outlined, 'bedroom'),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText('How many Bathroom'),
                  smallText('Please select how many bathroom is your property'),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', Icons.bathtub_outlined, 'bathroom'),
                      tinyHSpace(),
                      imageOption('2', Icons.bathtub_outlined, "bathroom"),
                      tinyHSpace(),
                      imageOption('3', Icons.bathtub_outlined, "bathroom"),
                      tinyHSpace(),
                      imageOption('4', Icons.bathtub_outlined, "bathroom",
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText('How many Shower'),
                  smallText('Please select how many shower is your property'),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', Icons.shower_outlined, 'shower'),
                      tinyHSpace(),
                      imageOption('2', Icons.shower_outlined, 'shower'),
                      tinyHSpace(),
                      imageOption('3', Icons.shower_outlined, 'shower'),
                      tinyHSpace(),
                      imageOption('4', Icons.shower_outlined, 'shower',
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText('How many Toilet'),
                  smallText('Please select how many toilet is your property'),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', Icons.flight_class_outlined, 'toilet'),
                      tinyHSpace(),
                      imageOption('2', Icons.flight_class_outlined, 'toilet'),
                      tinyHSpace(),
                      imageOption('3', Icons.flight_class_outlined, 'toilet'),
                      tinyHSpace(),
                      imageOption('4', Icons.flight_class_outlined, 'toilet',
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  title_icon(
                      'How many floors in your house', Icons.stairs_outlined),
                  tinySpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberButton('1', 'floors'),
                      numberButton('2', 'floors'),
                      numberButton('3', 'floors'),
                      numberButton('4', 'floors'),
                      numberButton('5', 'floors'),
                    ],
                  ),
                  kSpacing,
                  title_icon(
                      'How many square footage', Icons.square_foot_sharp),
                  tinySpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberButton('1', 'footage'),
                      numberButton('2', 'footage'),
                      numberButton('3', 'footage'),
                      numberButton('4', 'footage'),
                      numberButton('5', 'footage'),
                    ],
                  ),
                  kSpacing,
                  subText('      Or How many square meter'),
                  tinySpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberButton('1', 'square'),
                      numberButton('2', 'square'),
                      numberButton('3', 'square'),
                      numberButton('4', 'square'),
                      numberButton('5', 'square'),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  subText('Amenities'),
                  tinySpace(),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 5,
                    runSpacing: 8,
                    children: [
                      amenitiesButton(
                        Icons.wifi,
                        'wifi',
                      ),
                      amenitiesButton(
                        Icons.tv,
                        'tv',
                      ),
                      amenitiesButton(
                        Icons.thermostat,
                        'heater',
                      ),
                      amenitiesButton(
                        Icons.chair,
                        'chair',
                      ),
                      amenitiesButton(
                        Icons.print,
                        'print',
                      ),
                      amenitiesButton(
                        Icons.blender,
                        'blender',
                      ),
                      amenitiesButton(
                        Icons.sports_soccer,
                        'sports_soccer',
                      ),
                      amenitiesButton(
                        Icons.smoke_free,
                        'smoke_free',
                      ),
                      amenitiesButton(
                        Icons.water_drop_sharp,
                        'water',
                      ),
                      amenitiesButton(
                        Icons.tapas,
                        'tap',
                      ),
                      amenitiesButton(
                        Icons.accessible_forward,
                        'accessible',
                      ),
                      amenitiesButton(
                        Icons.settings_phone_outlined,
                        'phone',
                      ),
                    ],
                  ),
                  kSpacing,
                  title('House Rules'),
                  kSpacing,
                  title_icon(
                      'Allow People in the property', Icons.groups_rounded),
                  smallText(
                      'How many people are you allowed maximum in your property?'),
                  tinySpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberButton('1', 'occupant'),
                      numberButton('2', 'occupant'),
                      numberButton('3', 'occupant'),
                      numberButton('4', 'occupant'),
                      numberButton('5', 'occupant'),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  title_icon('Are pets allowed', Icons.pets),
                  tiny5Space(),
                  Row(
                    children: [
                      yesNoIcon('Yes', 'pet'),
                      smallHSpace(),
                      yesNoIcon('No', 'pet'),
                      mediumHSpace(),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  title_icon('Is smoke allowed', Icons.smoking_rooms),
                  tiny5Space(),
                  Row(
                    children: [
                      yesNoIcon('Yes', 'smoke'),
                      smallHSpace(),
                      yesNoIcon('No', 'smoke'),
                      mediumHSpace(),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  title('Description'),
                  kSpacing,
                  TextFieldWidget(
                    hint: "Description",
                    maxLine: 5,
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title('Set House location'),
                  kSpacing,
                  subText('Set the property location'),
                  TextFieldWidget(
                    hint: "Search location",
                    textController: addressController,
                    suffixIcon: const Icon(Icons.location_on_outlined),
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title('Choose one of the options'),
                  kSpacing,
                  Row(
                    children: [
                      rentOption('Rent Property'),
                      smallHSpace(),
                      rentOption('Sell Property'),
                    ],
                  ),
                  kSpacing,
                  title('Available for Rent'),
                  tinySpace(),
                  subText(
                    'Available start date',
                  ),
                  smallText(
                      'Please choose the date of availability for the rent'),
                  kSpacing,
                  InkWell(
                    onTap: () => selectDate().then((selectedDate) {
                      var picked = DateFormat.yMMMMd().format(selectedDate);
                      start = DateFormat('yyyy-MM-dd')
                          .format(selectedDate)
                          .toString();

                      var time = DateFormat.jm().format(selectedDate);
                      var day = DateFormat.EEEE().format(selectedDate);
                      startDate = picked.toString();
                      start = picked.toString();
                      startTime = time.toString();
                      startDay = day.toString();
                      setState(() {});
                    }),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: buttonneumorp().copyWith(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month, size: 18),
                                  tinyHSpace(),
                                  const Expanded(
                                    child: Text(
                                      'Start',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        smallHSpace(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: buttonneumorp().copyWith(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month, size: 18),
                                  tinyHSpace(),
                                  Expanded(
                                    child: Text(
                                      startDate,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tinySpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: buttonneumorp().copyWith(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_outlined,
                                    size: 18),
                                tinyHSpace(),
                                const Expanded(
                                  child: Text(
                                    'Time',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      smallHSpace(),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: buttonneumorp().copyWith(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_outlined,
                                    size: 18),
                                tinyHSpace(),
                                Expanded(
                                  child: Text(
                                    '$startDay: $startTime',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kSpacing,
                  subText(
                    'Available end date',
                  ),
                  smallText(
                      'Please choose the date of availability for the rent'),
                  kSpacing,
                  InkWell(
                    onTap: () => selectDate().then((selectedDate) {
                      var picked = DateFormat.yMMMMd().format(selectedDate);
                      end = DateFormat('yyyy-MM-dd')
                          .format(selectedDate)
                          .toString();
                      var time = DateFormat.jm().format(selectedDate);
                      var day = DateFormat.EEEE().format(selectedDate);
                      endDate = picked.toString();
                      endTime = time.toString();
                      endDay = day.toString();
                      setState(() {});
                    }),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: buttonneumorp().copyWith(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month, size: 18),
                                  tinyHSpace(),
                                  const Expanded(
                                    child: Text(
                                      'End Date',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        smallHSpace(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: buttonneumorp().copyWith(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month, size: 18),
                                  tinyHSpace(),
                                  Expanded(
                                    child: Text(
                                      endDate,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tinySpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: buttonneumorp().copyWith(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_outlined,
                                    size: 18),
                                tinyHSpace(),
                                const Expanded(
                                  child: Text(
                                    'Time',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      smallHSpace(),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: buttonneumorp().copyWith(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_outlined,
                                    size: 18),
                                tinyHSpace(),
                                Expanded(
                                  child: Text(
                                    '$endDay: $endTime',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  kSpacing,
                  title('Rent Price'),
                  kSpacing,
                  subText('Rental Price'),
                  smallText(
                      'You can choose only one option to make it visible on your post'),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Price",
                            textController: nightController),
                      ),
                      smallHSpace(),
                      const Text(
                        'Per night',
                        style: TextStyle(fontSize: 13, color: blue),
                      ),
                      tinyH5Space(),
                      const Icon(Icons.event_available_outlined)
                    ],
                  ),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Price",
                            textController: weekController),
                      ),
                      smallHSpace(),
                      const Text(
                        'Per week',
                        style: TextStyle(fontSize: 13, color: blue),
                      ),
                      tinyH5Space(),
                      const Icon(Icons.event_available_outlined)
                    ],
                  ),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Price",
                            textController: monthController),
                      ),
                      smallHSpace(),
                      const Text(
                        'Per month',
                        style: TextStyle(fontSize: 13, color: blue),
                      ),
                      tinyH5Space(),
                      const Icon(Icons.event_available_outlined)
                    ],
                  ),
                  kSpacing,
                  subText(
                    'Chose the currency',
                  ),
                  smallText('You can choose only one currency'),
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            prefixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/uz_flag.png',
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "So'm",
                                    style: TextStyle(color: light),
                                  ),
                                ),
                              ],
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "UZB",
                            enabled: false),
                      ),
                      horizontalSpace(0.25),
// Icon(Icons.)
                    ],
                  ),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            prefixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/us_flag.png',
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Dollar \$",
                                    style: TextStyle(color: lightGrey),
                                  ),
                                ),
                              ],
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "USA",
                            enabled: false),
                      ),
                      horizontalSpace(0.25),
// Icon(Icons.)
                    ],
                  ),
                  kSpacing,
                  subText(
                    'How do you want to accept the money?',
                  ),
                  smallText('You can choose only one money exchange'),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Meet cash Exchange",
                            enabled: false),
                      ),
                      smallHSpace(),
                      const Icon(
                        Icons.money,
                        size: 35,
                        color: grey,
                      ),
                      horizontalSpace(0.2),
// Icon(Icons.)
                    ],
                  ),
                  kSpacing,
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v) {}),
                      Expanded(
                        child: TextFieldWidget(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hint: "Online Transfer",
                            enabled: false),
                      ),
                      smallHSpace(),
                      const Icon(
                        Icons.money,
                        size: 35,
                        color: grey,
                      ),
                      horizontalSpace(0.2),
// Icon(Icons.)
                    ],
                  ),
                  kSpacing,
                  divider(),
                  kSpacing,
                  subText('Do you accept any offer?'),
                  smallText(
                      'If you want, you can accept any offer besides on post price'),
                  kSpacing,
                  Row(
                    children: [
                      yesNo('Yes', 'offer'),
                      smallHSpace(),
                      yesNo('No', 'offer'),
                      mediumHSpace(),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  kSpacing,
                  subText('Do you allow self check-in?'),
                  smallText(
                      'If you allow self check-in, you can drop or meet and give the key to tenant, or you can avoid this and say No to seld check-in'),
                  kSpacing,
                  kSpacing,
                  Row(
                    children: [
                      yesNo('Yes', 'checkin'),
                      smallHSpace(),
                      yesNo('No', 'checkin'),
                      mediumHSpace(),
                    ],
                  ),
                  verticalSpace(0.02),
                  Center(
                    child: InkWell(
                        onTap: () {
                          print('square -- > $square');
                          if (_formKey.currentState!.validate()) {
                            images.addAll(videos);
                            _storeController.createNewApartment(
                              _userController.getToken(),
                              storeId: widget.storeId,
                              title: nameController.text,
                              longitude: -97.4676,
                              latitude: 35.5164,
                              description: descriptionController.text,
                              smoke: smoke == 'Yes',
                              pet: pet == 'Yes',
                              propertyType: rentType == 'Rent Property'
                                  ? 'rental'
                                  : 'sale',
                              apartmentType: 'apartment',
                              nightAmount: nightController.text,
                              weekAmount: weekController.text,
                              monthAmount: monthController.text,
                              startDate: start,
                              amenities: amenities,
                              endDate: end,
                              bedroom: bed,
                              shower: shower,
                              bathroom: bathroom,
                              sqMeter: square,
                              toilet: toilet,
                              occupantsNumber: occupant,
                              floor: floor,
                              media: images,
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

  Divider divider() => Divider(color: blue.withOpacity(0.2), thickness: 3);

  getYesColor(title, description) {
    if (description == 'pet' && pet == title) {
      return red;
    } else if (description == 'smoke' && smoke == title) {
      return red;
    } else if (description == 'offer' && offer == title) {
      return red;
    } else if (description == 'checkin' && checkin == title) {
      return red;
    } else {
      return null;
    }
  }

  getYesTextColor(title, description) {
    if (description == 'pet' && pet == title) {
      return white;
    } else if (description == 'smoke' && smoke == title) {
      return white;
    } else if (description == 'offer' && offer == title) {
      return white;
    } else if (description == 'checkin' && checkin == title) {
      return white;
    } else {
      return grey;
    }
  }

  yesNoIcon(title, description) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (description == 'pet') {
              pet = title;
            } else {
              smoke = title;
            }
          });
        },
        child: Container(
          decoration: depressNeumorph().copyWith(
              color: getYesColor(title, description),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  description == 'pet' ? Icons.pets : Icons.smoking_rooms,
                  color: getYesTextColor(title, description),
                ),
                tinyHSpace(),
                Text(
                  title,
                  style: TextStyle(color: getYesTextColor(title, description)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  yesNo(title, description) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (description == 'offer') {
              offer = title;
            } else {
              checkin = title;
            }
          });
        },
        child: Container(
          decoration: depressNeumorph().copyWith(
              color: getYesColor(title, description),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: getYesTextColor(title, description)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getNumberTextColor(title, description) {
    if (description == 'floors' && floor == title) {
      return white;
    } else if (description == 'footage' && footage == title) {
      return white;
    } else if (description == 'square' && square == title) {
      return white;
    } else if (description == 'occupant' && occupant == title) {
      return white;
    } else {
      return black;
    }
  }

  getNumberColor(title, description) {
    if (description == 'floors' && floor == title) {
      return blue;
    } else if (description == 'footage' && footage == title) {
      return blue;
    } else if (description == 'square' && square == title) {
      return blue;
    } else if (description == 'occupant' && occupant == title) {
      return blue;
    } else {
      return null;
    }
  }

  InkWell numberButton(title, description) {
    return InkWell(
      onTap: () {
        setState(() {
          if (description == 'floors') {
            floor = title;
          } else if (description == 'footage') {
            footage = title;
          } else if (description == 'square') {
            square = title;
          } else if (description == 'occupant') {
            occupant = title;
          } else {
            // floor = '';
            // footage = '';
            // square = '';
            // occupant = '';
          }
        });
      },
      child: Container(
        decoration: depressNeumorph()
            .copyWith(color: getNumberColor(title, description)),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: getNumberTextColor(title, description)),
        ),
      ),
    );
  }

  InkWell amenitiesButton(icon, title) {
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
      child: Container(
        decoration: depressNeumorph()
            .copyWith(color: amenities.contains(title) ? blue : null),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Icon(icon, color: amenities.contains(title) ? white : black),
      ),
    );
  }

  Widget rentOption(title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            rentType = title;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: rentType == title
                ? gradient(
                    const Color(0xFF1A9AFF),
                    const Color(0xFF54FADC),
                  )
                : gradient(
                    const Color(0xFF1A9AFF).withOpacity(0.2),
                    const Color(0xFF54FADC).withOpacity(0.2),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: white),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Row title_icon(title, icon) {
    return Row(
      children: [
        Icon(icon),
        tinyH5Space(),
        Text(
          title,
          style: const TextStyle(
              color: blue, fontWeight: FontWeight.w500, fontSize: 17),
        ),
      ],
    );
  }


  Container discount() {
    return Container(
      decoration: buttonneumorp(),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: const Text(
        '10%',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  BoxDecoration buttonneumorp() {
    return BoxDecoration(
      color: const Color(0xFFE4EFF9),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFf334669), width: 0.1),
      gradient: linearGradient(),
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
    );
  }

  LinearGradient linearGradient() {
    return LinearGradient(
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
        tileMode: TileMode.repeated);
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
                  value: true,
                  // value: 'deliveryValue' == subText,
                  onChanged: (v) {
                    setState(() {
                      // deliveryValue = subText;
                    });
                  },
                ),
              ),
            )),
      ],
    );
  }


  getColor(description, title) {
    if (description == 'bedroom' && bedroom == title) {
      return blue;
    } else if (description == 'bathroom' && bathroom == title) {
      return blue;
    } else if (description == 'shower' && shower == title) {
      return blue;
    } else if (description == 'toilet' && toilet == title) {
      return blue;
    } else {
      return lightGrey;
    }
  }

  Widget imageOption(String title, IconData icon, description,
      {isNone = false, onTap}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (description == 'bedroom') {
              bedroom = title;
              bed = title.split(' ').last;
            } else if (description == 'bathroom') {
              bathroom = title;
            } else if (description == 'shower') {
              shower = title;
            } else if (description == 'toilet') {
              toilet = title;
            } else {
              toilet = 'None';
              bedroom = 'None';
              bathroom = 'None';
              toilet = 'None';
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: getColor(description, title)),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (isNone)
                  Column(
                    children: [
                      tiny15Space(),
                      Text(
                        'None',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: getColor(description, title),
                            fontSize: 15),
                      ),
                      tiny15Space(),
                    ],
                  ),
                if (!isNone)
                  Icon(
                    icon,
                    color: getColor(description, title),
                    size: 35,
                  ),
                tinySpace(),
                if (!isNone)
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: getColor(description, title),
                        fontSize: 13),
                  )
              ],
            ),
          ),
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

Text smallText(String title) => Text(
  title,
  style: const TextStyle(
      fontWeight: FontWeight.w300, color: grey, fontSize: 13),
);


Text subText(title) {
  return Text(
    title,
    style: const TextStyle(
        color: blue, fontWeight: FontWeight.w500, fontSize: 18),
  );
}

