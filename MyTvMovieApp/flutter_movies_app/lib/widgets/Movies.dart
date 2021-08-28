import 'package:flutter/material.dart';
import 'package:flutter_movies_app/constants.dart';
import 'package:flutter_movies_app/utility/Size_Config.dart';
import 'package:flutter_movies_app/widgets/movies/NowPlaying.dart';
import 'package:flutter_movies_app/widgets/movies/Popular.dart';
import 'package:flutter_movies_app/widgets/movies/TopRated.dart';
import 'package:flutter_movies_app/widgets/movies/UpComing.dart';

import 'movies/components/MoviesAppBar.dart';

class Movies extends StatefulWidget {
  Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  TextEditingController _searchTED = TextEditingController();
  int selectedCategory = 0;
  List<String> categories = ['Now Playing', 'Popular', 'Top Rated', 'Upcoming'];
  List<Widget> moviesCarausel = [
    NowPlaying(),
    Popular(),
    TopRated(),
    UpComing()
  ];

  @override
  void dispose() {
    _searchTED.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(children: [
      MoviesAppBar(),
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
      SizedBox(height: kDefaultPadding),
      Expanded(child: moviesCarausel.elementAt(selectedCategory)),
    ]);
  }
}
