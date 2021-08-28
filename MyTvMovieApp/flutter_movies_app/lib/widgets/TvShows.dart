import 'package:flutter/material.dart';
import 'package:flutter_movies_app/screens/TvShowSearchScreen.dart';
import 'package:flutter_movies_app/utility/Size_Config.dart';
import 'package:flutter_movies_app/widgets/movies/TopRated.dart';
import 'package:flutter_movies_app/widgets/movies/UpComing.dart';
import 'package:flutter_movies_app/widgets/tv/AiringToday.dart';
import 'package:flutter_movies_app/widgets/tv/OnTheAir.dart';
import 'package:flutter_movies_app/widgets/tv/PopularTv.dart';
import 'package:flutter_movies_app/widgets/tv/TopRatedTv.dart';
import 'package:flutter_movies_app/widgets/tv/components/TvAppBar.dart';

import '../constants.dart';

class TvShows extends StatefulWidget {
  TvShows({Key? key}) : super(key: key);

  @override
  _TvShowsState createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  TextEditingController _searchTED = TextEditingController();
  int selectedCategory = 0;
  List<String> categories = [
    'Airing Today',
    'On The Air',
    'Popular',
    'Top Rated'
  ];
  List<Widget> tvCarausel = [
    AiringToday(),
    OnTheAir(),
    PopularTv(),
    TopRatedTv(),
  ];
  @override
  void dispose() {
    _searchTED.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(children: [
      TvAppBar(),
      Container(
          height: SizeConfig.screenHeight * 0.08,
          //color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1.5),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(categories[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: index == selectedCategory
                                              ? kTextColor
                                              : Colors.black.withOpacity(0.4))),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2),
                              width: SizeConfig.safeBlockHorizontal * 8,
                              height: SizeConfig.safeBlockVertical * 0.75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: index == selectedCategory
                                      ? kSecondaryColor
                                      : Colors.transparent),
                            )
                          ]))))),
      //Genres(),
      SizedBox(height: kDefaultPadding),
      Expanded(child: tvCarausel.elementAt(selectedCategory)),
    ]);
  }
}
