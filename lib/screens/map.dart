import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


class Map extends StatefulWidget {
  Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  String? mapStyle;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.5164, -97.4676);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/mapstyle').then((string) {
      mapStyle = string;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
  }

  zoomIn() async{
    var currentZoomLevel = await mapController.getZoomLevel();

    currentZoomLevel = currentZoomLevel + 0.5;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  zoomOut() async{
    var currentZoomLevel = await mapController.getZoomLevel();
    currentZoomLevel = currentZoomLevel - 0.5;
    if (currentZoomLevel < 0) currentZoomLevel = 0;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),


          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                SizedBox(height: 40.w,),
                MapIcons(Image.asset("assets/images/icons/apartment.png",), grey,),
                MapIcons(Image.asset("assets/images/icons/houseRental.png",), grey,),
                MapIcons(Image.asset("assets/images/icons/Dacha.png",), grey,),
              ],
            ),
          ),




          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MapIcons(Icon(Icons.add, color: white, size: 20.w,), black, onTap: zoomIn,),
              MapIcons(Icon(Icons.remove, color: white,size: 20.w,),black, onTap: zoomOut),
              SizedBox(height: 30.w,),
              MapIcons(Transform.rotate(angle: 0.6, child: Icon(Icons.navigation, color: white,size: 20.w,),), black,
                  onTap: (){
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _center,
                          zoom: 11,
                        ),
                      ),);
                  }),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
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
                              child: Text("5 bedroom and 2 bath Apartment . great view and sall pool for kids are great options",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w700
                                ),),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


InkWell MapIcons (icon, color, {onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
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
