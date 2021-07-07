import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my__weather_app/controller/WeatherController.dart';

class AqiAstro extends StatelessWidget {
  AqiAstro({Key? key}) : super(key: key);
  final WeatherController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          AqiCard(controller: controller),
          AstroCard(controller: controller)
        ]));
  }
}

class AstroCard extends StatelessWidget {
  const AstroCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
            child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Expanded(
                          child: Text('Astro',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sunrise'),
                            Text(controller.astroCurrent.value.sunrise)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sunset'),
                            Text(controller.astroCurrent.value.sunset)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Moonrise'),
                            Text(controller.astroCurrent.value.moonrise)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Moonset'),
                            Text(controller.astroCurrent.value.moonset)
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('Moon Phase'),
                            Text(controller.astroCurrent.value.moonPhase)
                          ]))
                    ])))));
  }
}

class AqiCard extends StatelessWidget {
  const AqiCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
            child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Expanded(
                          child: Text(
                        'Air Quality',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CO'),
                            Text(controller.current.value.airQuality['co']!
                                .toInt()
                                .toString())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('NO2'),
                            Text(controller.current.value.airQuality['no2']!
                                .toInt()
                                .toString())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('O3'),
                            Text(controller.current.value.airQuality['o3']!
                                .toInt()
                                .toString())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SO2'),
                            Text(controller.current.value.airQuality['so2']!
                                .toInt()
                                .toString())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('PM 2.5'),
                            Text(controller.current.value.airQuality['pm2_5']!
                                .toInt()
                                .toString())
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('PM 10'),
                            Text(controller.current.value.airQuality['pm10']!
                                .toInt()
                                .toString())
                          ]))
                    ])))));
  }
}
