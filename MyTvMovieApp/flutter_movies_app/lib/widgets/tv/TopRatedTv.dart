import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_movies_app/provider/TvShowsProivder.dart';
import 'package:flutter_movies_app/screens/TvShowDetailsScreen.dart';
import 'package:flutter_movies_app/utility/Size_Config.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class TopRatedTv extends StatefulWidget {
  TopRatedTv({Key? key}) : super(key: key);

  @override
  _TopRatedTvState createState() => _TopRatedTvState();
}

class _TopRatedTvState extends State<TopRatedTv> {
  var _isInit = true;
  var _isLoading = false;
  late PageController _pageController;
  int initalPage = 1;
  int newPage = 2;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(viewportFraction: 0.8, initialPage: initalPage);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TvShowsProvider>(context).getTopRated().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TvShowsProvider temp = Provider.of<TvShowsProvider>(context, listen: false);
    _pageController.addListener(() {
      if (_pageController.offset >= _pageController.position.maxScrollExtent &&
          !_pageController.position.outOfRange) {
        // reached bottom
        if (newPage < 3) {
          temp.addMoreTopRatedTv(nextPage: newPage);
          newPage += 1;
        } else {
          temp.setNoMore = true;
        }
        print('Bottom Firing');
      }
      if (_pageController.offset <= _pageController.position.minScrollExtent &&
          !_pageController.position.outOfRange) {
        // reached top
        print('Firing Top');
      }
    });
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            //margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Consumer<TvShowsProvider>(
            builder: (ctx, tvProvider, _) {
              return PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      initalPage = value;
                    });
                  },
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  itemCount: tvProvider.popularLS.length,
                  itemBuilder: (ctx, index) =>
                      buildTvShowSlider(tvProvider, index, context));
            },
          ));
  }

  Widget buildTvShowSlider(
      TvShowsProvider tvProvider, int index, BuildContext context) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (ctx, child) {
          double value = 0.0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page!;
            value = (value * 0.038).clamp(-1, 1);
          }
          return AnimatedOpacity(
              duration: Duration(milliseconds: 350),
              opacity: initalPage == index ? 1 : 0.4,
              child: Transform.rotate(
                  angle: math.pi * value,
                  child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TvShowDetailsScreen(
                              tvId: tvProvider.topRatedLS[index].id))),
                      child: Column(children: [
                        Expanded(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    boxShadow: [kDefaultShadow]),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: BlurHash(
                                      hash: 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.',
                                      image: 'https://image.tmdb.org/t/p/w500' +
                                          tvProvider
                                              .topRatedLS[index].posterPath,
                                    )))),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 2),
                          child: Text(tvProvider.topRatedLS[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: kDefaultPadding / 4),
                                  Text(
                                      tvProvider.topRatedLS[index].voteAverage
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText2)
                                ]))
                      ]))));
        });
  }
}
