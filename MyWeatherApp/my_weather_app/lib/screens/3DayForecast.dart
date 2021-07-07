import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/model/WeatherData.dart';
import 'package:my__weather_app/utility/Size_Config.dart';

class ThreeDayForecast extends StatelessWidget {
  ThreeDayForecast({Key? key}) : super(key: key);
  final WeatherController controller = Get.find();
  String uvIndex = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView.separated(
      itemCount: controller.threeDayForecastLS.length,
      separatorBuilder: (ctx, sepIndex) {
        return Divider();
      },
      itemBuilder: (ctx, outIndex) {
        Forecastday forecastDay = controller.threeDayForecastLS[outIndex];
        String date = controller.getDateForThreeDayForecast(forecastDay);
        return Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.40,
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        date,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              Expanded(
                  flex: 8,
                  child: Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: forecastDay.hour.length,
                          itemBuilder: (ctx, inIndex) {
                            Hour hourForecast = forecastDay.hour[inIndex];
                            List<String> dateTime =
                                controller.getDateTime(hourForecast.timeEpoch);
                            uvIndex = controller.getUvIndex(hourForecast);
                            return Container(
                                width: SizeConfig.screenWidth * 0.50,
                                child: Card(
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Column(children: [
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: Row(children: [
                                            Expanded(
                                                child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        12,
                                                    imageUrl: 'https:' +
                                                        hourForecast
                                                            .condition.icon,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            color: Colors.grey,
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                  Text(
                                                      hourForecast
                                                          .condition.text,
                                                      textAlign:
                                                          TextAlign.center),
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                                    child: Column(children: [
                                              Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  hourForecast.tempC
                                                          .toString() +
                                                      '\u2103',
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                    Text(dateTime.first,
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                2.75)),
                                                    Text(dateTime.last,
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                2.75))
                                                  ]))
                                            ])))
                                          ]))),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Wind'),
                                                          Text(hourForecast
                                                                  .windKph
                                                                  .toInt()
                                                                  .toString() +
                                                              'km/h')
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Wind Dir'),
                                                          Text(hourForecast
                                                              .windDir)
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Pressure (mb)'),
                                                          Text(hourForecast
                                                              .pressureMb
                                                              .toInt()
                                                              .toString())
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Precip (mm)'),
                                                          Text(hourForecast
                                                              .precipMm
                                                              .toInt()
                                                              .toString())
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Humidity (%)'),
                                                          Text(hourForecast
                                                                  .humidity
                                                                  .toString() +
                                                              '%')
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5.0),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('UV Index'),
                                                        Text(uvIndex)
                                                      ]),
                                                ))
                                              ])))
                                    ])));
                          })))
            ]));
      },
    );
  }
}
