import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my__weather_app/model/WeatherData.dart' as wData;
import 'package:my__weather_app/services/GetLocation.dart';
import 'package:my__weather_app/services/GetWeatherData.dart';

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var location = wData.Location(
          name: '',
          region: '',
          country: '',
          lat: 0.0,
          lon: 0.0,
          tzId: '',
          localtimeEpoch: 0,
          localtime: '')
      .obs;

  var current = wData.Current(
      lastUpdatedEpoch: 0,
      lastUpdated: '',
      tempC: 0.0,
      tempF: 0.0,
      isDay: 0,
      condition: wData.Condition(text: '', icon: '', code: 0),
      windMph: 0.0,
      windKph: 0.0,
      windDegree: 0,
      windDir: '',
      pressureMb: 0.0,
      pressureIn: 0.0,
      precipMm: 0.0,
      precipIn: 0.0,
      humidity: 0,
      cloud: 0,
      feelslikeC: 0.0,
      feelslikeF: 0.0,
      visKm: 0.0,
      visMiles: 0,
      uv: 0,
      gustMph: 0.0,
      gustKph: 0.0,
      airQuality: {}).obs;
  var forecastLS = <wData.Forecastday>[].obs;
  var astroCurrent = wData.Astro(
          moonIllumination: '',
          moonPhase: '',
          moonrise: '',
          moonset: '',
          sunrise: '',
          sunset: '')
      .obs;

  var currentHourForecastLS = <wData.Hour>[].obs;
  var threeDayForecastLS = <wData.Forecastday>[].obs;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  var isNetworkConnected = false.obs;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isNetworkConnected(true);
      } else if (result == ConnectivityResult.wifi) {
        isNetworkConnected(true);
      } else if (result == ConnectivityResult.none) {
        isNetworkConnected(false);
      }
    });
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  void initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await connectivity.checkConnectivity();

      print('Result: ' + result.toString());
      if (result == ConnectivityResult.mobile) {
        isNetworkConnected(true);
      } else if (result == ConnectivityResult.wifi) {
        isNetworkConnected(true);
      } else if (result == ConnectivityResult.none) {
        isNetworkConnected(false);
      }
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
  }

  void getCurrentLocation() async {
    try {
      isLoading(true);
      Position currentPosition = await GetLocation.determinePosition();
      searchByLatLong(
          lat: currentPosition.latitude, long: currentPosition.longitude);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void searchByLatLong({required double lat, required double long}) async {
    try {
      wData.WeatherData? weatherData =
          await GetWeatherData.fetchWeatherData(lat: lat, long: long);
      if (weatherData != null) {
        getWeatherData(weatherData);
      }
    } finally {
      isLoading(false);
    }
  }

  void searchByName({required String name}) async {
    try {
      isLoading(true);
      wData.WeatherData? weatherData =
          await GetWeatherData.searchWeatherData(city: name);
      if (weatherData != null) {
        getWeatherData(weatherData);
      }
    } catch (e, s) {
      print(e);
      print(s);
    } finally {
      isLoading(false);
    }
  }

  void getWeatherData(wData.WeatherData weatherData) {
    location.value = weatherData.location;
    current.value = weatherData.current;
    forecastLS.value = weatherData.forecast.forecastday;
    astroCurrent.value = weatherData.forecast.forecastday.first.astro;
    threeDayForecastLS.addAll([
      weatherData.forecast.forecastday.first,
      weatherData.forecast.forecastday[1],
      weatherData.forecast.forecastday.last
    ]);

    currentHourForecastLS.value = weatherData.forecast.forecastday.first.hour;
  }

  String getDateForThreeDayForecast(wData.Forecastday forecastday) {
    String date = DateFormat('dd MMM,yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(forecastday.dateEpoch * 1000));
    return date;
  }

  String getUvIndex(wData.Hour hourForecast) {
    if (hourForecast.uv >= 0 && hourForecast.uv <= 2) {
      return 'Low';
    } else if (hourForecast.uv >= 3 && hourForecast.uv <= 5) {
      return 'Moderate';
    } else if (hourForecast.uv >= 6 && hourForecast.uv <= 7) {
      return 'High';
    } else if (hourForecast.uv >= 8 && hourForecast.uv <= 10) {
      return 'Very High';
    } else if (hourForecast.uv > 11) {
      return 'Extreme';
    } else
      return '';
  }

  List<String> getDateTime(int timeEpoch) {
    // String hourDate = DateFormat('EEE, dd MMM,yyyy').format(
    //     DateTime.fromMillisecondsSinceEpoch(hourForecast.timeEpoch * 1000));
    // String hourTime = DateFormat('hh:mm a').format(
    //     DateTime.fromMillisecondsSinceEpoch(hourForecast.timeEpoch * 1000));
    return [
      DateFormat('EEE, dd MMM,yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(timeEpoch * 1000)),
      DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(timeEpoch * 1000))
    ];
  }

  String getWindType(double speed) {
    if (speed >= 1 && speed <= 11) {
      return 'Light';
    } else if (speed >= 12 && speed <= 28) {
      return 'Gentle Breeze';
    } else if (speed >= 29 && speed <= 38) {
      return 'Fresh Wind';
    } else if (speed > 38) {
      return 'Strong';
    } else
      return '';
  }
}
