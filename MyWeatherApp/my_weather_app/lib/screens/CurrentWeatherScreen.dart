import 'package:flutter/material.dart';
import 'package:my__weather_app/utility/Size_Config.dart';
import 'package:my__weather_app/widgets/AqiAstroCards.dart';
import 'package:my__weather_app/widgets/CurrentWeatherCard.dart';
import 'package:my__weather_app/widgets/PrecipitationCard.dart';
import 'package:my__weather_app/widgets/SearchWidget.dart';
import 'package:my__weather_app/widgets/WindCard.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(shrinkWrap: true, children: [
      SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.10,
          child: SearchByName()),
      CurrentWeather(),
      SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.25,
          child: AqiAstro()),
      SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.25,
        child: Precipitation(),
      ),
      SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.30,
        child: WindCard(),
      )
    ]);
  }
}
