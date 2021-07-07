import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/screens/3DayForecast.dart';
import 'package:my__weather_app/screens/CurrentWeatherScreen.dart';
import 'package:my__weather_app/utility/Size_Config.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final WeatherController controller = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text('MyWeather',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            bottom: TabBar(
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle:
                  TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3),
              tabs: [
                Tab(
                  child: Text('TODAY'),
                ),
                Tab(
                  child: Text(
                    '3 Days',
                  ),
                )
              ],
            ),
          ),
          body: Obx(() => controller.isNetworkConnected.value
              ? controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [CurrentWeatherScreen(), ThreeDayForecast()])
              : Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Please check your internet connection '),
                      Icon(Icons.warning, color: Colors.amber)
                    ]))),
        ),
      ),
    );
  }
}
