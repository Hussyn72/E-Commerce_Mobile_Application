import 'package:JF_InfoTech/base/custom_button.dart';
import 'package:JF_InfoTech/controllers/location_controllar.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/route_helper.dart';
class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController;
  const PickAddressMap({Key? key, required this.fromSignup, required this.fromAddress, this.GoogleMapController}) : super(key: key);
  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition=LatLng(19.063188, 72.879854);
      _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
      }
    }
  }
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(initialCameraPosition: CameraPosition
                  (target: _initialPosition,zoom: 17
                ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition){
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: (){
                    Get.find<LocationController>().updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: !locationController.loading?Image.asset("assets/image/pick_marker.png",
                  height: 50,width: 50,
                  ):CircularProgressIndicator()
                ),
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,size: 25,color: AppColors.yellowColor,),
                        Expanded(child: Text(
                          '${locationController.pickPlacemark.name??''}',
                              style:TextStyle(
                            color: Colors.white,
                        ),
                            maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                ),
                  Positioned(
                    bottom: 70,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: CustomButton(
                        buttonText: "Pick Address",
                        onPressed: locationController.loading?null:(){
                          if(locationController.pickPosition.latitude!=0&&
                          locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.GoogleMapController!=null){
                                  widget.GoogleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition
                                    (target: LatLng(locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude))));
                                                  locationController.setAddressData();
                              }
                              Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }
                        },
                      )
                  )
              ],
            ),
          ),
        ),

        ),
      );
    });
  }
}
