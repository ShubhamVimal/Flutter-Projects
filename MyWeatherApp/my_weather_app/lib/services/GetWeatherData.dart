import 'package:dio/dio.dart';
import 'package:my__weather_app/model/WeatherData.dart';

class GetWeatherData {
  static var client = Dio();

  static Future<WeatherData?> fetchWeatherData(
      {required double lat, required double long}) async {
    try {
      var response = await client.get(
          'http://api.weatherapi.com/v1/forecast.json?key=9028ee0c1281479d812144856212406&q=$lat,$long&days=3&aqi=yes&alerts=no');
      if (response.statusCode == 200) {
        var jsonData = response.data;

        return weatherDataFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<WeatherData?> searchWeatherData({required String city}) async {
    try {
      var response = await client.get(
          'http://api.weatherapi.com/v1/forecast.json?key=9028ee0c1281479d812144856212406&q=$city&days=3&aqi=yes&alerts=no');
      if (response.statusCode == 200) {
        var jsonData = response.data;

        return weatherDataFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
