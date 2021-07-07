import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/model/WeatherData.dart';
import 'package:my__weather_app/utility/Size_Config.dart';

class Precipitation extends StatelessWidget {
  Precipitation({Key? key}) : super(key: key);

  final WeatherController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Precipitation',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Row(children: [
                  Expanded(
                      child: Column(children: [
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text('Volume\n(mm)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3)),
                    )),
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text('Time',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 3))))
                  ])),
                  Expanded(
                      flex: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.currentHourForecastLS.length,
                              itemBuilder: (ctx, index) {
                                Hour hourForecast =
                                    controller.currentHourForecastLS[index];
                                String hourTime = DateFormat('h a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        hourForecast.timeEpoch * 1000));
                                return Container(
                                    width: SizeConfig.screenWidth * 0.10,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                    'assets/icons/drop.png')),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(hourForecast.precipMm
                                                  .toInt()
                                                  .toString()),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(hourTime,
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3))),
                                          )
                                        ]));
                              })))
                ]),
              )
            ])));
  }
}
