import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/model/WeatherData.dart';
import 'package:my__weather_app/utility/Size_Config.dart';

class WindCard extends StatelessWidget {
  WindCard({Key? key}) : super(key: key);
  final WeatherController controller = Get.find();
  String windType = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    windType =
        controller.getWindType(controller.currentHourForecastLS.first.windKph);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child:
                  Text('Wind', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
                child: Container(
                    child: Row(children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: controller.currentHourForecastLS.first.windKph
                                .toInt()
                                .toString(),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 10,
                                color: Colors.blue)),
                        TextSpan(
                            text: ' km/h',
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                                color: Colors.grey))
                      ])))),
              Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(windType,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize:
                                    SizeConfig.safeBlockHorizontal * 5.5)),
                        Text(
                            'Now \u2022 From ' +
                                controller.currentHourForecastLS.first.windDir,
                            textAlign: TextAlign.start)
                      ]))
            ]))),
            Expanded(
                flex: 2,
                child: Row(children: [
                  Expanded(
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                        Expanded(child: Container()),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text('Wind\n(km/h)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3)),
                        )),
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text('Time',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                3))))
                      ]))),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.currentHourForecastLS.length,
                            itemBuilder: (ctx, index) {
                              Hour hourForecast =
                                  controller.currentHourForecastLS[index];
                              String hourTime = DateFormat('h a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      hourForecast.timeEpoch * 1000));
                              return Container(
                                width: SizeConfig.screenWidth * 0.10,
                                child: Column(children: [
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset('assets/icons/wind.png'),
                                  )),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    child: Text(hourForecast.windKph
                                        .toInt()
                                        .toString()),
                                  )),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(hourTime,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3))))
                                ]),
                              );
                            }),
                      ))
                ]))
          ])),
    );
  }
}
