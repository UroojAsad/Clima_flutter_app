import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
 @override
 void initState( ) {
   super.initState();
   getlocation();
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

 void getdata() async {
   final uri = Uri.parse('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289@10d714a6e88630761fae22');
   http.Response response = await http.get(uri);

   if(response.statusCode==200){
     String data= response.body;

     var decodedData=jsonDecode(data);

     var temperature = decodedData['main']['temp'];
     var condition = decodedData ['weather'][0]['id'];
     var cityName = decodedData['name'];
     print(temperature);
     print(condition);
     print(cityName);

   }else{
     print(response.statusCode);
   }
 }

  @override
  Widget build(BuildContext context) {
   getdata();
    return Scaffold();
  }
}
