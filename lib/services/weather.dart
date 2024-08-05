import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey= 'c739971182dcb9e4000a0574488ddebc';
const openWeatherUrl='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityLocation(String CityName) async{

    networkHelper networkhelper=networkHelper
      ('$openWeatherUrl?q=$CityName&appid=$apiKey&units=metric');
  var weatherData=  await networkhelper.getdata();
  return weatherData;
  }


 Future<dynamic> getLocationWeather() async{
    Location location =Location();
    await location.getCurrentLocation();


    networkHelper networkhelper=networkHelper(
     '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');


    var weatherData= await networkhelper.getdata();
    return weatherData;

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
