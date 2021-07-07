import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/utility/Size_Config.dart';

class CurrentWeather extends StatelessWidget {
  CurrentWeather({
    Key? key,
  }) : super(key: key);

  final WeatherController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<String> dateTime =
        controller.getDateTime(controller.location.value.localtimeEpoch);
    String cityName = controller.location.value.name.isNotEmpty
        ? controller.location.value.name
        : controller.location.value.region;
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.25,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                      Column(
                        children: [
                          Text(
                              cityName +
                                  ',' +
                                  controller.location.value.country,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4)),
                          Text(
                              controller.current.value.tempC.toString() +
                                  '\u2103',
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 9))
                        ],
                      ),
                      Column(
                        children: [Text(dateTime.first), Text(dateTime.last)],
                      )
                    ]))),
                Expanded(
                    child: Container(
                        child: Column(children: [
                  Expanded(
                      child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https:' + controller.current.value.condition.icon,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    color: Colors.grey,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Expanded(
                        child: Text(
                          controller.current.value.condition.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Max'),
                              Text(controller.forecastLS.first.day.maxtempC
                                      .toString() +
                                  '\u2103')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Min'),
                              Text(controller.forecastLS.first.day.mintempC
                                      .toString() +
                                  '\u2103')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Wind'),
                              Text(controller.current.value.windKph.toString() +
                                  ' km/h')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Wind Dir'),
                              Text(controller.current.value.windDir)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Humidity'),
                                Text(controller.current.value.humidity
                                        .toString() +
                                    '%')
                              ]),
                        )
                      ])))
                ])))
              ]),
            )));
  }
}
