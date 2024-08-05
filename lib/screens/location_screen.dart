import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {

  final locatonWeather;

  LocationScreen({this.locatonWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather=WeatherModel();

  int temperature=5;
  String weatherIcon='';
  String cityName='nai abadi';
  String WheatherMessage='';

  @override
  void initState() {
    super.initState();
    UpdateUI(widget.locatonWeather);
  }

  void UpdateUI(dynamic weatherData){
 setState(() {
   if(weatherData==0){
     temperature=0;
     weatherIcon='Error';
     cityName='';
     return;
   }

   double temp = weatherData['main']['temp'];
   temperature=temp.toInt();
   var condition = weatherData ['weather'][0]['id'];
   weatherIcon=weather.getWeatherIcon(condition);
   WheatherMessage=weather.getMessage(temperature);
   cityName = weatherData['name'];
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData= await weather.getLocationWeather();
                      UpdateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var TypedName=  await Navigator.push(context, MaterialPageRoute(builder:(context){
                        return CityScreen();
                      }));
                      if(TypedName!=null){
                       var weatherData = await weather.getCityLocation(TypedName);
                       UpdateUI(weatherData);

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$WheatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



