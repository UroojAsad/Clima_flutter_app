import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';



class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
 @override
 void initState( ) {
   super.initState();
   requestLocationPermission();

 }



 void requestLocationPermission() async {
   var status = await Permission.location.status;
   if (status.isGranted) {
     getlocation();
   } else if (status.isDenied || status.isPermanentlyDenied) {
     if (await Permission.location.request().isGranted) {
       getlocation();
     } else {
       // Handle the case when permission is denied
       print('Location permission denied');
     }
   }
 }



  void getlocation() async{
 Location location =Location();
  await location.getCurrentLocation();
  print(location.latitude);
  print(location.longitude);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
