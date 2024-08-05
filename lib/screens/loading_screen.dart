import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



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
     getlocationData();
   } else if (status.isDenied || status.isPermanentlyDenied) {
     if (await Permission.location.request().isGranted) {
       getlocationData();
     } else {
       // Handle the case when permission is denied
       print('Location permission denied');
     }
   }
 }



  void getlocationData() async{
   var weatherData=  await WeatherModel().getLocationWeather();

Navigator.push(context, MaterialPageRoute(builder: (context){
  return LocationScreen(locatonWeather: weatherData,);
}));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
