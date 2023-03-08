import 'package:fenix/screens/onboarding/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Fenix Map",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 17.w,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),),
          automaticallyImplyLeading: false,
          // leading: Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: gradient(
                  const Color(0xFF691232),
                  const Color(0xFF1770A2),
                ),
            ),
          )),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
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
            )
          ),
        ],
      ),
    );
  }
}
