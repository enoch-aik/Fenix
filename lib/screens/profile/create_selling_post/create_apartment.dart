import 'dart:io';
import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/subscribe/plans.dart';
import 'package:fenix/screens/profile/subscribe/subscribe.dart';
import 'package:fenix/screens/profile/wallets/add_new_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../controller/map_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../helpers/image_picker.dart';
import '../../../neumorph.dart';
import '../../../theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreateApartment extends StatefulWidget {
  final String storeId;
  final String apartmentType;

  CreateApartment(
      {Key? key, required this.storeId, required this.apartmentType})
      : super(key: key);

  @override
  State<CreateApartment> createState() => _CreateApartmentState();
}

class _CreateApartmentState extends State<CreateApartment> {
  PageController pageController = PageController();
  final UserController _userController = Get.find();
  final MapController _mapController = Get.find();
  final StoreController _storeController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final nightController = TextEditingController();
  final priceController = TextEditingController();
  final weekController = TextEditingController();
  final monthController = TextEditingController();
  final startAvailabilityController = TextEditingController();
  final startTimeAvailabilityController = TextEditingController();
  final endAvailabilityController = TextEditingController();
  final endTimeAvailabilityController = TextEditingController();

  final floorsCustomController = TextEditingController();
  final footageCustomController = TextEditingController();
  final squareCustomController = TextEditingController();
  final occupantCustomController = TextEditingController();

  final startTimeController = TextEditingController(text: "00:00");
  final endTimeController = TextEditingController(text: "00:00");

  DateRangePickerController startDateRangePickerController = DateRangePickerController();
  DateRangePickerController endDateRangePickerController = DateRangePickerController();


  double longitude = 0.0;
  double latitude = 0.0;
  String storeId = '';
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
  String startMonth = '';
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

  String store = '';
  List<String> stores = [];
  List<String> storeIds = [];

  RxBool nightSwitch = false.obs;
  RxBool weekSwitch = false.obs;
  RxBool monthSwitch = false.obs;

  Rx<Widget> customTextField =  Container().obs;
  Rx<Widget> customTextField1 =  Container().obs;
  Rx<Widget> customTextField2 =  Container().obs;
  Rx<Widget> customTextField3 =  Container().obs;

  RxBool floorsClicked = false.obs;
  RxBool squareClicked = false.obs;
  RxBool footageClicked = false.obs;
  RxBool occupantClicked = false.obs;

  String timeOfDay = "";

  double loginAlign = -1;
  double signInAlign = 1;
  Color selectedColor = Colors.white;
  Color normalColor = black;

  double xAlign = 0;

  Color loginColor = Colors.white;
  Color signInColor = black;

  RxString startTimeOfDayString = "".obs;
  RxString endTimeOfDayString = "".obs;

  getLocation(){
    // _handlePressButton();
  }

//   Future<void> _handlePressButton() async {
//     void onError(PlacesAutocompleteResponse response) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response.errorMessage ?? 'Unknown error'),
//         ),
//       );
//     }
//
//     final p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: _mapController.googleApikey,
//       onError: onError,
//       mode: Mode.overlay,
//       language: 'en',
//       components: [Component(Component.country, 'US')],
//       resultTextStyle: Theme.of(context).textTheme.subtitle1,
//     );
//
//     await displayPrediction(p, ScaffoldMessenger.of(context));
//   }
//
//
// Future<void> displayPrediction(
//     Prediction? p, ScaffoldMessengerState messengerState) async {
//   if (p == null) {
//     return;
//   }
//
//   final _places = GoogleMapsPlaces(
//     apiKey: _mapController.googleApikey,
//   );
//
//   final detail = await _places.getDetailsByPlaceId(p.placeId!);
//   final geometry = detail.result.geometry!;
//   final lat = geometry.location.lat;
//   final lng = geometry.location.lng;
//
//   setState(() {
//     addressController.text = p.description!;
//     latitude = lat;
//     longitude = lng;
//   });
// }

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
            DateTime.now().year+7, DateTime.now().month + 4, DateTime.now().day));

    // return '';
  }



  List<String>? getStoreListNames() {
    for (var i = 0; i < _storeController.storeList.length; i++) {
      stores.add(_storeController.storeList[i]['name']);
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
    getStoreIds();
    storeId = stores[0];
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.050,
                    width: MediaQuery.of(context).size.width * 0.80,
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
                                fontSize: 17.w, color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search, size: 30.w,),
                        suffixIcon: Icon(
                          Icons.qr_code_scanner,
                          color: primary,
                          size: 26.w,
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${AppLocalizations.of(context)!.sellRent} ${widget.apartmentType}",
              style: const TextStyle(fontWeight: FontWeight.w400),
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
                  title( AppLocalizations.of(context)!.store),
                  smallText( AppLocalizations.of(context)!.storeSubText),
                        kSpacing,
                  DropDownWidget(
                      list: stores,
                      store: store,
                      items: stores.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        var index =  stores.indexOf(val!);
                        setState(() {
                          store = val;
                        });
                        storeId = storeIds[index];
                      }),

                  kSpacing,
                  title( AppLocalizations.of(context)!.photos),
                  smallText( AppLocalizations.of(context)!.photosSubText),
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
                  const Divider(color: light, thickness: 3),
                  kSpacing,
                  title( AppLocalizations.of(context)!.titleOfProperty),
                  smallText( AppLocalizations.of(context)!.titleOfPropertySubText),
                  kSpacing,
                  TextFieldWidget(
                    hint:  AppLocalizations.of(context)!.nameOfProduct,
                    textController: nameController,
                    validator: (value) => FieldValidator.validate(value!),
                  ),
                  kSpacing,
                  title( AppLocalizations.of(context)!.houseSpecifics),
                  kSpacing,
                  subText( AppLocalizations.of(context)!.howManyBedrooms),
                  smallText( AppLocalizations.of(context)!.howManyBedroomsSubText),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('Bedroom 1', Icons.hotel_outlined, '', 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 2', Icons.hotel_outlined, '', 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 3', Icons.hotel_outlined, '', 'bedroom'),
                      tinyHSpace(),
                      imageOption('Bedroom 4', Icons.hotel_outlined, '', 'bedroom'),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText( AppLocalizations.of(context)!.howManyBathrooms),
                  smallText( AppLocalizations.of(context)!.howManyBathroomsSubText),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', Icons.bathtub_outlined, '', 'bathroom'),
                      tinyHSpace(),
                      imageOption('2', Icons.bathtub_outlined, '', "bathroom"),
                      tinyHSpace(),
                      imageOption('3', Icons.bathtub_outlined, '', "bathroom"),
                      tinyHSpace(),
                      imageOption('4', Icons.bathtub_outlined, '', "bathroom",
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText( AppLocalizations.of(context)!.howManyShower),
                  smallText( AppLocalizations.of(context)!.howManyShowerSubText),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', Icons.shower_outlined, 'shower.png', 'shower'),
                      tinyHSpace(),
                      imageOption('2', Icons.shower_outlined, 'shower.png', 'shower'),
                      tinyHSpace(),
                      imageOption('3', Icons.shower_outlined, 'shower.png', 'shower'),
                      tinyHSpace(),
                      imageOption('4', Icons.shower_outlined, 'shower.png', 'shower',
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  subText( AppLocalizations.of(context)!.howManyToilet),
                  smallText( AppLocalizations.of(context)!.howManyToiletSubText),
                  kSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageOption('1', FontAwesomeIcons.toilet, 'toilet.png', 'toilet'),
                      tinyHSpace(),
                      imageOption('2', Icons.flight_class_outlined, 'toilet.png', 'toilet'),
                      tinyHSpace(),
                      imageOption('3', Icons.flight_class_outlined, 'toilet.png', 'toilet'),
                      tinyHSpace(),
                      imageOption('4', Icons.flight_class_outlined, 'toilet.png', 'toilet',
                          isNone: true),
                    ],
                  ),
                  tiny5Space(),
                  divider(),
                  title_icon(
                      AppLocalizations.of(context)!.howManyFloors, Icons.stairs_outlined, 'stairs.png'),
                  tinySpace(),
                  Wrap(
                    spacing: 12.w,
                    children: [
                      numberButton('1', 'floors'),
                      numberButton('2', 'floors'),
                      numberButton('3', 'floors'),
                      numberButton('Custom', 'customFloors'),
                      // numberButton('4', 'floors'),
                      // numberButton('5', 'floors'),
                    ],
                  ),
                  customTextField.value,
                  kSpacing,
                  title_icon(
                      AppLocalizations.of(context)!.howManySquareFootage, Icons.square_foot_sharp, 'squareRoot.png'),
                  tinySpace(),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 17.w,
                    children: [
                      numberButton('2', 'footage'),
                      numberButton('3', 'footage'),
                      numberButton('4', 'footage'),
                      numberButton('5', 'footage'),
                      numberButton('6', 'footage'),
                      numberButton('7', 'footage'),
                      numberButton('8', 'footage'),
                      numberButton('9', 'footage'),
                      numberButton('Custom', 'customFootage'),
                    ],
                  ),
                  customTextField1.value,
                  kSpacing,
                  subText( AppLocalizations.of(context)!.howManySquareMeters),
                  tinySpace(),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 17.w,
                    children: [
                      numberButton('20 Square ', 'square'),
                      numberButton('30 Square ', 'square'),
                      numberButton('40 Square ', 'square'),
                      numberButton('50 Square ', 'square'),
                      numberButton('60 Square ', 'square'),
                      numberButton('70 Square ', 'square'),
                      numberButton('80 Square ', 'square'),
                      numberButton('90 Square ', 'square'),
                      numberButton('100 Square ', 'square'),
                      numberButton('110 Square ', 'square'),
                      numberButton('120 Square ', 'square'),
                      numberButton('130 Square ', 'square'),
                      numberButton('Custom', 'customSquare'),
                    ],
                  ),
                  customTextField2.value,
                  kSpacing,
                  divider(),
                  subText( AppLocalizations.of(context)!.amenities),
                  smallText("Please choose the amenities in your apartament has"),
                  tinySpace(),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 5,
                    runSpacing: 8,
                    children: [
                      amenitiesButton('wifi',),
                      amenitiesButton('tv',),
                      amenitiesButton('basketballNet'),
                      amenitiesButton('pets',),
                      amenitiesButton('microwave',),
                      amenitiesButton('restaurant',),
                      amenitiesButton('laundary',),
                      amenitiesButton('chair',),
                      amenitiesButton('billiards',),
                      amenitiesButton('blender',),
                      amenitiesButton('coffeeMaker',),
                      amenitiesButton('cooker',),
                      amenitiesButton('kitchen',),
                      amenitiesButton('sports_soccer',),
                      amenitiesButton('hairDryer',),
                      amenitiesButton('hanger',),
                      amenitiesButton('tap',),
                      amenitiesButton('lamp',),
                      amenitiesButton('parking',),
                      amenitiesButton('playstation',),
                      amenitiesButton('print',),
                      amenitiesButton('refrigerator',),
                      amenitiesButton('smoke_free',),
                      amenitiesButton('air_conditioning',),
                      amenitiesButton('sprinker',),
                      amenitiesButton('heater',),
                      amenitiesButton('phone',),
                      amenitiesButton('uber',),
                      amenitiesButton('washer',),
                      amenitiesButton('water',),
                      amenitiesButton('accessible',),
                    ],
                  ),
                  kSpacing,
                  title( AppLocalizations.of(context)!.houseRules),
                  kSpacing,
                  title_icon(
                      AppLocalizations.of(context)!.allowPeople, Icons.groups_rounded, ''),
                  smallText(AppLocalizations.of(context)!.allowPeopleSubText),
                  tinySpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberButton('1', 'occupant'),
                      numberButton('2', 'occupant'),
                      numberButton('3', 'occupant'),
                      numberButton('4', 'occupant'),
                      numberButton('Custom', 'customOccupant'),
                    ],
                  ),
                  customTextField3.value,
                  kSpacing,
                  divider(),
                  title_icon( AppLocalizations.of(context)!.petsAllowed, Icons.pets, ''),
                  tiny5Space(),
                  Row(
                    children: [
                      yesNoIcon( AppLocalizations.of(context)!.yes,  AppLocalizations.of(context)!.pet),
                      smallHSpace(),
                      yesNoIcon( AppLocalizations.of(context)!.no,  AppLocalizations.of(context)!.pet),
                      mediumHSpace(),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  title_icon( AppLocalizations.of(context)!.smokeAllowed, Icons.smoking_rooms, ''),
                  tiny5Space(),
                  Row(
                    children: [
                      yesNoIcon( AppLocalizations.of(context)!.yes,  AppLocalizations.of(context)!.smoke),
                      smallHSpace(),
                      yesNoIcon( AppLocalizations.of(context)!.no,  AppLocalizations.of(context)!.smoke),
                      mediumHSpace(),
                    ],
                  ),
                  kSpacing,
                  divider(),
                  title( AppLocalizations.of(context)!.description),
                  kSpacing,
                  TextFieldWidget(
                    hint:  AppLocalizations.of(context)!.description,
                    maxLine: 5,
                    textController: descriptionController,
                  ),
                  kSpacing,
                  title( AppLocalizations.of(context)!.setHouseLocation),
                  kSpacing,
                  subText( AppLocalizations.of(context)!.setPropertyLocation),
                  smallText("You can write the address of the property on the search section "),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.2),
                    child: SearchGooglePlacesWidget(
                      placeType: PlaceType.address, // PlaceType.cities, PlaceType.geocode, PlaceType.region etc
                      placeholder:  AppLocalizations.of(context)!.searchLocation,
                      apiKey: _mapController.googleApikey,
                      onSearch: (Place place) {},
                      onSelected: (Place place) async {
                        addressController.text = place.description!;
                        place.geolocation!.then((value) {
                          LatLng location = value!.coordinates;
                          setState(() {
                            latitude = location.latitude;
                            longitude = location.longitude;
                          });
                        });


                      },
                    ),
                  ),
                  kSpacing,
                  title( AppLocalizations.of(context)!.chooseOptions),
                  kSpacing,
                  Row(
                    children: [
                      rentOption('Rent Property'),
                      smallHSpace(),
                      rentOption('Sell Property'),
                    ],
                  ),
                  kSpacing,
                  if (rentType == 'Rent Property')
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      title( AppLocalizations.of(context)!.availableForRent),
                      tinySpace(),
                      subText(
                        'Available start date',
                      ),
                      smallText(
                          'Please choose the date the availability starts for the rent'),
                      kSpacing,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: buttonneumorp().copyWith(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                     Expanded(
                                      child: Text(
                                        'Start',
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                    Expanded(
                                      child: Text(
                                        startDate,
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      tinySpace(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: buttonneumorp().copyWith(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time_outlined,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                     Expanded(
                                      child: Text(
                                        'Time',
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time_outlined,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                    Expanded(
                                      child: Text(
                                        '$startDay: $startTime',
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SfDateRangePicker(
                                  view: DateRangePickerView.month,
                                  showNavigationArrow: true,
                                  backgroundColor: white,
                                  initialSelectedDate: DateTime.now(),
                                  initialDisplayDate: DateTime.now(),
                                  selectionColor: red,
                                  controller: startDateRangePickerController,
                                  onSelectionChanged: (d){
                                    print(startDateRangePickerController.selectedDate);
                                    var picked = DateFormat.yMMMMd().format(startDateRangePickerController.selectedDate!);
                                    start = DateFormat('yyyy-MM-dd')
                                        .format(startDateRangePickerController.selectedDate!)
                                        .toString();
                                    var day = DateFormat.EEEE().format(startDateRangePickerController.selectedDate!);
                                    startDay = day.toString();
                                    setState(() {
                                      startDate = picked.toString();
                                    });
                                    startAvailabilityController.text = "$startDate $startDay";
                                  },

                                  headerStyle: DateRangePickerHeaderStyle(
                                      textStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          color: blue,
                                          fontSize: 17.w
                                      )
                                  ),
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                    textStyle: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      color: blue,
                                      fontSize: 17.w
                                    ),
                                  ),
                                  monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Time",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          color: black,
                                          fontSize: 17.w
                                      ),),

                                      InkWell(
                                        onTap: () async {
                                          TimeOfDay? pickedTime =  await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if(pickedTime != null ){
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat("h:mm").format(parsedTime);
                                            String formattedTimeOfDay = DateFormat("a").format(parsedTime);
                                            setState(() {
                                              startTimeController.text = formattedTime;
                                              startTime = "$formattedTime $formattedTimeOfDay";

                                              startTimeAvailabilityController.text = formattedTime;
                                            });
                                            startTimeOfDayString.value = formattedTimeOfDay;
                                          }else{
                                            print("Time is not selected");
                                          }
                                        },

                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.25),
                                            borderRadius: BorderRadius.circular(10.w)
                                          ),
                                          child: Text(startTimeController.text,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: 20.w
                                          ),),),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      kSpacing,
                      subText('Available end date'),
                      smallText(
                          'Please choose the date the availability ends for the rent'),
                      kSpacing,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: buttonneumorp().copyWith(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                     Expanded(
                                      child: Text(
                                        'End Date',
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 18, color: dark),
                                    tinyHSpace(),
                                    Expanded(
                                      child: Text(
                                        endDate,
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      tinySpace(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: buttonneumorp().copyWith(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time_outlined,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!.time,
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time_outlined,
                                        size: 18, color: dark,),
                                    tinyHSpace(),
                                    Expanded(
                                      child: Text(
                                        '$endDay: $endTime',
                                        style: GoogleFonts.roboto(fontSize: 16, color: dark),
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SfDateRangePicker(
                                  view: DateRangePickerView.month,
                                  showNavigationArrow: true,
                                  backgroundColor: white,
                                  initialSelectedDate: DateTime.now(),
                                  initialDisplayDate: DateTime.now(),
                                  selectionColor: red,
                                  controller: endDateRangePickerController,
                                  onSelectionChanged: (d){
                                    print(endDateRangePickerController.selectedDate);
                                    var picked = DateFormat.yMMMMd().format(endDateRangePickerController.selectedDate!);
                                    start = DateFormat('yyyy-MM-dd')
                                        .format(endDateRangePickerController.selectedDate!)
                                        .toString();
                                    var day = DateFormat.EEEE().format(endDateRangePickerController.selectedDate!);
                                    endDay = day.toString();
                                    setState(() {
                                      endDate = picked.toString();
                                    });

                                    endAvailabilityController.text = "$endDate $endDay";


                                  },

                                  headerStyle: DateRangePickerHeaderStyle(
                                      textStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          color: blue,
                                          fontSize: 17.w
                                      )
                                  ),
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                    textStyle: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        color: blue,
                                        fontSize: 17.w
                                    ),
                                  ),
                                  monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Time",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            color: black,
                                            fontSize: 17.w
                                        ),),

                                      InkWell(
                                        onTap: () async {
                                          TimeOfDay? pickedTime =  await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if(pickedTime != null ){
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            String formattedTime = DateFormat("h:mm").format(parsedTime);
                                            String formattedTimeOfDay = DateFormat("a").format(parsedTime);
                                            setState(() {
                                              endTimeController.text = formattedTime;
                                              endTime = "$formattedTime $formattedTimeOfDay";
                                              print(formattedTimeOfDay);
                                              endTimeAvailabilityController.text = formattedTime;
                                              //set the value of text field.
                                            });
                                            endTimeOfDayString.value = formattedTimeOfDay;
                                          }else{
                                            print("Time is not selected");
                                          }
                                        },

                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.25),
                                              borderRadius: BorderRadius.circular(10.w)
                                          ),
                                          child: Text(endTimeController.text,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: 20.w
                                            ),),),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          kSpacing,
                          kSpacing,
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: blue, width: 1)
                                ),
                                child: Icon(Icons.calendar_month, color: blue,),
                              ),
                              smallHSpace(),
                              subText('Final Result of Availability'),
                            ],
                          ),
                          kSpacing,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subText('Start Date'),
                             tinySpace(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width() * 0.59,
                                    child: TextFieldWidget(
                                        hint: startAvailabilityController.text,
                                        enabled: false,
                                    ),
                                  ),
                                  tinyHSpace(),
                                  SizedBox(

                                    width: width() * 0.19,
                                    child: TextFieldWidget(
                                        hint: startTimeAvailabilityController.text,
                                        enabled: false,
                                    ),
                                  ),
                                  tinyHSpace(),
                                  Obx(() => startTimeOfDayString.value == "AM" ?
                                  Icon(Icons.sunny, color: grey,)   : Icon(FontAwesomeIcons.moon, color: grey,)) ,
                                ],
                              ),
                              smallHSpace(),
                              kSpacing,
                              subText('End Date'),
                              tinySpace(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width() * 0.59,
                                    child: TextFieldWidget(
                                        hint: endAvailabilityController.text,
                                        enabled: false,
                                    ),
                                  ),
                                  tinyHSpace(),
                                  SizedBox(
                                    width: width() * 0.19,
                                    child: TextFieldWidget(
                                      hint: endTimeAvailabilityController.text,
                                      enabled: false,
                                    ),
                                  ),
                                  tinyHSpace(),
                                  Obx(() => endTimeOfDayString.value == "AM" ?
                                  Icon(Icons.sunny, color: grey,)   : Icon(FontAwesomeIcons.moon, color: grey,)) ,
                                ],
                              ),
                              smallHSpace(),
                            ],
                          ),

                      kSpacing,
                          divider(),
                          kSpacing,
                          title("Rent Price"),
                          kSpacing,
                          subText('Rental Price'),
                          smallText(
                              'You can  choose only one  option to make it visable on your post '),
                          kSpacing,
                          Row(
                            children: [
                              CupertinoSwitch(value: nightSwitch.value, onChanged: (v) {
                                setState(() {
                                  nightSwitch.value = v;
                                  if(nightSwitch.value == true){
                                    monthSwitch.value = false;
                                    monthController.clear();
                                    weekSwitch.value = false;
                                    weekController.clear();
                                  }
                                });
                              }),
                              Expanded(
                                child: TextFieldWidget(
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true),
                                    hint:  AppLocalizations.of(context)!.price,
                                    enabled: nightSwitch.value,
                                    textController: nightController),
                              ),
                              smallHSpace(),
                               Text(
                                AppLocalizations.of(context)!.perNight,
                                style: TextStyle(fontSize: 13, color: blue),
                              ),
                              tinyH5Space(),
                              const Icon(Icons.event_available_outlined)
                            ],
                          ),
                          kSpacing,
                          Row(
                            children: [
                              CupertinoSwitch(value: weekSwitch.value, onChanged: (v) {
                                setState(() {
                                  weekSwitch.value = v;
                                  if(weekSwitch.value == true){
                                    monthSwitch.value = false;
                                    monthController.clear();
                                    nightSwitch.value = false;
                                    nightController.clear();
                                  }
                                });
                              }),
                              Expanded(
                                child: TextFieldWidget(
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true),
                                    hint:  AppLocalizations.of(context)!.price,
                                    enabled: weekSwitch.value,
                                    textController: weekController),
                              ),
                              smallHSpace(),
                               Text(
                                 AppLocalizations.of(context)!.perWeek,
                                style: TextStyle(fontSize: 13, color: blue),
                              ),
                              tinyH5Space(),
                              const Icon(Icons.event_available_outlined)
                            ],
                          ),
                          kSpacing,
                          Row(
                            children: [
                              CupertinoSwitch(value: monthSwitch.value, onChanged: (v) {
                                setState(() {
                                  monthSwitch.value = v;
                                  if(monthSwitch.value == true){
                                    nightSwitch.value = false;
                                    nightController.clear();
                                    weekSwitch.value = false;
                                    weekController.clear();
                                  }
                                });
                              }),
                              Expanded(
                                child: TextFieldWidget(
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true),
                                    hint:  AppLocalizations.of(context)!.price,
                                    enabled: monthSwitch.value,
                                    textController: monthController),
                              ),
                              smallHSpace(),
                             Text(
                                AppLocalizations.of(context)!.perMonth,
                                style: TextStyle(fontSize: 13, color: blue),
                              ),
                              tinyH5Space(),
                              const Icon(Icons.event_available_outlined)
                            ],
                          ),
                          kSpacing,
                    ]),

                  if (rentType == 'Sell Property') Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      title('Available for sale'),
                      kSpacing,
                      subText('Sale Price'),
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
                          tinyH5Space(),
                          const Icon(Icons.event_available_outlined)
                        ],
                      ),
                      kSpacing,
                    ],
                  ),

//                   subText(
//                     'Chose the currency',
//                   ),
//                   smallText('You can choose only one currency'),
//                   Row(
//                     children: [
//                       CupertinoSwitch(value: true, onChanged: (v) {}),
//                       Expanded(
//                         child: TextFieldWidget(
//                             prefixIcon: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     'assets/images/uz_flag.png',
//                                     width: 40,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             suffixIcon: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "So'm",
//                                     style: TextStyle(color: light),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             keyboardType: const TextInputType.numberWithOptions(
//                                 decimal: true),
//                             hint: "UZB",
//                             enabled: false),
//                       ),
//                       horizontalSpace(0.25),
// // Icon(Icons.)
//                     ],
//                   ),
//                   kSpacing,
//                   Row(
//                     children: [
//                       CupertinoSwitch(value: true, onChanged: (v) {}),
//                       Expanded(
//                         child: TextFieldWidget(
//                             prefixIcon: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     'assets/images/us_flag.png',
//                                     width: 40,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             suffixIcon: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Dollar \$",
//                                     style: TextStyle(color: lightGrey),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             keyboardType: const TextInputType.numberWithOptions(
//                                 decimal: true),
//                             hint: "USA",
//                             enabled: false),
//                       ),
//                       horizontalSpace(0.25),
// // Icon(Icons.)
//                     ],
//                   ),
//                   kSpacing,
//                   subText(
//                     'How do you want to accept the money?',
//                   ),
//                   smallText('You can choose only one money exchange'),
//                   kSpacing,
//                   Row(
//                     children: [
//                       CupertinoSwitch(value: true, onChanged: (v) {}),
//                       Expanded(
//                         child: TextFieldWidget(
//                             keyboardType: const TextInputType.numberWithOptions(
//                                 decimal: true),
//                             hint: "Meet cash Exchange",
//                             enabled: false),
//                       ),
//                       smallHSpace(),
//                       const Icon(
//                         Icons.money,
//                         size: 35,
//                         color: grey,
//                       ),
//                       horizontalSpace(0.2),
// // Icon(Icons.)
//                     ],
//                   ),
//                   kSpacing,
//                   Row(
//                     children: [
//                       CupertinoSwitch(value: true, onChanged: (v) {}),
//                       Expanded(
//                         child: TextFieldWidget(
//                             keyboardType: const TextInputType.numberWithOptions(
//                                 decimal: true),
//                             hint: "Online Transfer",
//                             enabled: false),
//                       ),
//                       smallHSpace(),
//                       const Icon(
//                         Icons.money,
//                         size: 35,
//                         color: grey,
//                       ),
//                       horizontalSpace(0.2),
// // Icon(Icons.)
//                     ],
//                   ),
//                   kSpacing,
//                   divider(),
//                   kSpacing,
//                   subText('Do you accept any offer?'),
//                   smallText(
//                       'If you want, you can accept any offer besides on post price'),
//                   kSpacing,
//                   Row(
//                     children: [
//                       yesNo('Yes', 'offer'),
//                       smallHSpace(),
//                       yesNo('No', 'offer'),
//                       mediumHSpace(),
//                     ],
//                   ),
//                   kSpacing,
//                   divider(),
//                   kSpacing,
//                   subText('Do you allow self check-in?'),
//                   smallText(
//                       'If you allow self check-in, you can drop or meet and give the key to tenant, or you can avoid this and say No to seld check-in'),
//                   kSpacing,
                  kSpacing,
                  // Row(
                  //   children: [
                  //     yesNo('Yes', 'checkin'),
                  //     smallHSpace(),
                  //     yesNo('No', 'checkin'),
                  //     mediumHSpace(),
                  //   ],
                  // ),
                  verticalSpace(0.02),
                  Center(
                    child: InkWell(
                        onTap: () {
                          Get.to(() => Subscribe());
                        },
                        child: ButtonWidget(title: AppLocalizations.of(context)!.choosePlans,color: Colors.blue,)),
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
                              longitude: longitude,
                              latitude: latitude,
                              description: descriptionController.text,
                              smoke: smoke == 'Yes',
                              pet: pet == 'Yes',
                              propertyType: rentType == 'Rent Property'
                                  ? 'rental'
                                  : 'sale',
                              apartmentType: widget.apartmentType,
                              salePrice: priceController.text,
                              nightAmount: nightController.text,
                              weekAmount: weekController.text,
                              monthAmount: monthController.text,
                              startDate: start,
                              amenities: amenities,
                              endDate: end,
                              bedroom: bed,
                              shower: shower,
                              bathroom: bathroom,
                              sqMeter: squareCustomController,
                              toilet: toilet,
                              occupantsNumber: occupantCustomController,
                              floor: floorsCustomController,
                              media: images,
                            );
                          } else {
                            CustomSnackBar.failedSnackBar('Error',
                                'Ensure that all required fields are filled');
                          }
                        },
                        child: ButtonWidget(title: AppLocalizations.of(context)!.createFreePost)),
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



  getYesColor(title, description) {
    if (description == 'pet' && pet == title && title == "No") {
      return red;
    } else if (description == 'pet' && pet == title && title == "Yes") {
      return blue;
    } else if (description == 'smoke' && smoke == title && title == "No") {
      return red;
    } else if (description == 'smoke' && smoke == title && title == "Yes") {
      return blue;
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
      return iconGrey;
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

  // const TextInputType.numberWithOptions(
  // decimal: true, ),

  Widget getCustomTextField(controller, hint, keyboardType){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: TextFieldWidget(
            keyboardType: keyboardType,
            hint: hint,
            textController: controller,
        ),
    );
  }

  InkWell numberButton(title, description) {
    return InkWell(
      onTap: () {
        setState(() {
          if (description == 'floors') {
            floorsCustomController.text = title;
          } else if (description == 'footage') {
            footageCustomController.text = title;
          } else if (description == 'square') {
            squareCustomController.text = title;
          } else if (description == 'occupant') {
            occupantCustomController.text = title;
          } else if (description == 'customFloors') {
            if(floorsClicked.value == false){
              floorsClicked.value = true;
              customTextField.value = getCustomTextField(
                  floorsCustomController, "How many floors", TextInputType.number);
            } else{
              floorsClicked.value = false;
              floorsCustomController.clear();
              customTextField.value = Container();
            }
          } else if (description == 'customFootage') {
            if(footageClicked.value == false){
              footageClicked.value = true;
              customTextField1.value = getCustomTextField(
                  footageCustomController, "How many square Footage", TextInputType.number);
            } else{
              footageClicked.value = false;
              footageCustomController.clear();
              customTextField1.value = Container();
            }
          } else if (description == 'customSquare') {
            if(squareClicked.value == false){
              squareClicked.value = true;
              customTextField2.value = getCustomTextField(
                  squareCustomController, "How many square meters", TextInputType.text);
            } else {
              squareClicked.value = false;
              squareCustomController.clear();
              customTextField2.value = Container();
            }
          } else if (description == 'customOccupant') {
            if(occupantClicked.value == false){
              occupantClicked.value = true;
              customTextField3.value = getCustomTextField(
                  occupantCustomController, "How many occupants", TextInputType.number);
            } else {
              occupantClicked.value = false;
              occupantCustomController.clear();
              customTextField3.value = Container();
            }
          } else {
            // floor = '';
            // footage = '';
            // square = '';
            // occupant = '';
          }
        });
      },
      child: Container(
        decoration: depressNeumorphDark()
            .copyWith(color: title == "Custom" ? Color(0xFFE48C24) : getNumberColor(title, description),
          borderRadius: BorderRadius.circular(7.w)
        ),
        padding:  EdgeInsets.symmetric(vertical: 7, horizontal: title == "Custom" ? 10  : (description ==  "square") ? 9 :  25),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: title == "Custom" ? white : getNumberTextColor(title, description)),
        ),
      ),
    );
  }

  InkWell amenitiesButton(title) {
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
        decoration: depressNeumorph().copyWith(color: amenities.contains(title) ? blue : null),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 21.w),
        child: Image.asset('assets/images/apartmentIcons/$title.png', scale: height()/38, color: amenities.contains(title) ? white : iconGrey),
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

  Row title_icon(title, icon, image) {
    return Row(
      children: [
        (image.isEmpty) ? Icon(icon) : Image.asset('assets/images/apartmentIcons/$image', scale: height()/30,),
        tinyH5Space(),
        Text(
          title,
          style: TextStyle(
              color: blue, fontWeight: FontWeight.w500, fontSize: 18.w),
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
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
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
          const Color(0xFFE4F0FA).withOpacity(0.99),
          const Color(0xFFE5E6EC).withOpacity(0.99),
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
      return iconGrey75;
    }
  }

  getColor2(description, title) {
    if (description == 'bedroom' && bedroom == title) {
      return blue;
    } else if (description == 'bathroom' && bathroom == title) {
      return blue;
    } else if (description == 'shower' && shower == title) {
      return blue;
    } else if (description == 'toilet' && toilet == title) {
      return blue;
    } else {
      return iconGrey;
    }
  }

  Widget imageOption(String title, IconData icon, String image, description,
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
              border: Border.all(color: iconGrey65),
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
                            fontWeight: FontWeight.w600,
                            color: iconGrey,
                            fontSize: 15),
                      ),
                      tiny15Space(),
                    ],
                  ),
                if (!isNone)
                  (image.isEmpty) ? Icon(
                    icon,
                    color: getColor(description, title),
                    size: 35,
                  ) : Image.asset('assets/images/apartmentIcons/$image',color: (image.isEmpty) ? getColor(description, title) : getColor2(description, title), scale: height()/60,),
                tinySpace(),
                if (!isNone)
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: iconGrey,
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
              child: Icon(icon ?? Icons.photo_camera, color: iconGrey65),
      )
    ),
  );
}

Text smallText(String title) => Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w300, color: grey, fontSize: 13),
    );

Text subText(title) {
  return Text(
    title,
    style:
        const TextStyle(color: blue, fontWeight: FontWeight.w500, fontSize: 18),
  );
}


Divider divider() => Divider(color: blue.withOpacity(0.2), thickness: 4);


class TimeofDayToggle extends StatefulWidget {
  const TimeofDayToggle({Key? key}) : super(key: key);

  @override
  State<TimeofDayToggle> createState() => _TimeofDayToggleState();
}

class _TimeofDayToggleState extends State<TimeofDayToggle> {

  double loginAlign = -1;
  double signInAlign = 1;
  Color selectedColor = Colors.white;
  Color normalColor = black;

  double xAlign = 1;

  Color loginColor = black;
  Color signInColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: 120 * 0.5,
              height: 40,
              decoration: const BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                loginColor = selectedColor;

                signInColor = normalColor;
              });
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: 120 * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'AM',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: loginColor,
                      fontSize: 16.w
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                signInColor = selectedColor;
                loginColor = normalColor;
              });
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: 120 * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'PM',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: signInColor,
                      fontSize: 16.w
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
