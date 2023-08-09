import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:fenix/controller/map_controller.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../controller/user_controller.dart';
import '../helpers/icons/custom_icons_fenix_icons.dart';



class Map extends StatefulWidget {
  Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  String? mapStyle;

  final MapController _mapController = Get.find();
  final UserController _userController = Get.find();

  LatLng _center = const LatLng(36.79582, -88.64801);

  late List<MarkerData> _customMarkers;

  Color color =  Color(0xFFDADADA);

  List<MarkerData> _list = [];
  BitmapDescriptor? customIcon;



  getMarkers(){
    for(var i = 0; i < _mapController.apartmentList.length; i++){
      var item = _mapController.apartmentList[i];
      _list.add(
          MarkerData(
              marker:
              Marker( markerId: MarkerId(item['id'].toString()),  position: LatLng(item['latitude'],item['longitude']),
              onTap: (){
               setState(() {
                 _mapController.apartmentListClicked.clear();
                 _mapController.apartmentListClicked.add(item);
                 print(_mapController.apartmentListClicked);
                 color = Colors.red;
               });
              }),
              child: _customMarkerWidget(item['rentPrice']['month'].toString(), color )),
         );
    }
    _customMarkers.addAll(_list);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/mapstyle').then((string) {
      mapStyle = string;
    });
    _customMarkers = [];
    getMarkers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapController.googleMapController.dispose();
    _mapController.apartmentListClicked.clear();
  }



  void _onMapCreated(GoogleMapController controller) {
    _mapController.googleMapController = controller;
    _mapController.googleMapController.setMapStyle(mapStyle);
    controller.dispose();
  }

  onCameraMove(CameraPosition position){
      _center = position.target;
  }

  zoomIn() async{
    var currentZoomLevel = await _mapController.googleMapController.getZoomLevel();

    currentZoomLevel = currentZoomLevel + 1;
    _mapController.googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  zoomOut() async{
    var currentZoomLevel = await _mapController.googleMapController.getZoomLevel();
    currentZoomLevel = currentZoomLevel - 1;
    if (currentZoomLevel < 0) currentZoomLevel = 0;
    _mapController.googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }


  getFilterMarkers(){
    for(var i = 0; i < _mapController.apartmentFilterList.length; i++){
      var item = _mapController.apartmentFilterList[i];
      _list.add(
        MarkerData(
            marker:
            Marker( markerId: MarkerId(item['id'].toString()),  position: LatLng(item['latitude'],item['longitude']),),
            child: _customMarkerWidget(item['rentPrice']['month'].toString(), Colors.blue,
            onTap: (){
              print("ddddd");

            })),
      );
    }
    _customMarkers.addAll(_list);
  }


  filterApartments(type){
    for (var i = 0; i < _mapController.apartmentList.length; i++) {
      var result = _mapController.apartmentList.where((apartment) => apartment["apartmentType"] == type);
      setState(() {
        _mapController.apartmentFilterList.value = [];
        _mapController.apartmentFilterList.addAll(result);
        _list.clear();
        _customMarkers.clear();
        getFilterMarkers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomGoogleMapMarkerBuilder(
        customMarkers: _customMarkers,
        builder: (BuildContext context, Set<Marker>? markers) {
          if (markers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: markers,
                myLocationEnabled: true,
                onCameraMove: onCameraMove,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: false,
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
              ),


              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    SizedBox(height: 40.w,),
                    MapIcons(Icon( CustomIconsFenix.apartment, color: white, size: 16.w,), black, type: "apartment",
                        onTap: (){
                      filterApartments("apartment");

                        }),
                    MapIcons(Icon( CustomIconsFenix.house, color: white, size: 16.w,), black,type: "house",
                        onTap: (){
                          filterApartments("house");
                        }),
                    MapIcons(Icon( CustomIconsFenix.dacha, color: white, size: 16.w,), black,type: "dacha",
                    onTap: (){
                      filterApartments("dacha");
                    }),
                  ],
                ),
              ),




              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MapIcons(Icon(CustomIconsFenix.plus, color: white, size: 16.w,), black, onTap: zoomIn,),
                  MapIcons(Icon(CustomIconsFenix.minus, color: white,size: 16.w,),black, onTap: zoomOut),
                  SizedBox(height: 65.w,),
                  
                  MapIcons(Icon(CustomIconsFenix.navigation, color: white,size: 16.w,), black,type: "navigation",
                      onTap: (){
                        print(_userController.userCurrentPosition!.value!.longitude);
                        print(_userController.userCurrentPosition!.value!.latitude);
                        _mapController.googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(_userController.userCurrentPosition!.value!.latitude, _userController.userCurrentPosition!.value!.longitude),
                              zoom: 11,
                            ),
                          ),);
                      }),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: _mapController.apartmentListClicked.isEmpty ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _mapController.apartmentList.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.w),
                                  // border: Border.all(color: Color(0xFF1994F5), width: 3),
                                  image: DecorationImage(image: AssetImage("assets/images/house.png",),fit: BoxFit.fitWidth)
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.052,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13.w), bottomRight: Radius.circular(13.w)),
                                ),
                                child: Center(
                                  child: Text(_mapController.apartmentList[index]['description'],
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.white,
                                        fontSize: 12.w,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ),
                              ),
                            ),
                          );
                        }) : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
                          child: Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.w),
                            border: Border.all(color: Color(0xFF1994F5), width: 3),
                            image: DecorationImage(image: AssetImage("assets/images/house.png",),fit: BoxFit.fitWidth)
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.052,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13.w), bottomRight: Radius.circular(13.w)),
                          ),
                          child: Center(
                            child: Text(_mapController.apartmentListClicked[0]['description'],
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                      ),
                    ),
                        ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}



InkWell _customMarkerWidget(String text, Color color,{onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding:  EdgeInsets.all(3.w),
      decoration: BoxDecoration(
          color: color,

          borderRadius: BorderRadius.circular(20.w),),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.w),
        decoration: BoxDecoration(
            color: Color(0xFFC9C9C9),
            borderRadius: BorderRadius.circular(20.w),),
        child: Center(
            child: Text(text,
                style: TextStyle(
                fontSize: 11.w,
                color: blue,
                  fontWeight: FontWeight.bold
            ),
            )),
      ),
    ),
  );
}

InkWell MapIcons (icon, color, {type, onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
        padding: EdgeInsets.all(11.w),
        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: (type == "navigation") ? [
            BoxShadow(
              color: dark.withOpacity(0.8),
              blurRadius: 3.0,
              spreadRadius: 0.5,
              offset: Offset(1.0, 3.0), // shadow direction: bottom right
            )
          ] : [],
        ),
        child: icon
    ),
  );
}

// class MapIcons extends StatelessWidget {
//
//   Widget icon;
//   Color color;
//
//   MapIcons({
//     Key? key, required this.icon, required this.color,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.w),
//       margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//       ),
//       child: icon
//     );
//   }
// }
