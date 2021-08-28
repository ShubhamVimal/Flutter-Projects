import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_movies_app/provider/TvShowsProivder.dart';
import 'package:flutter_movies_app/utility/Size_Config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class TvShowDetailsScreen extends StatefulWidget {
  TvShowDetailsScreen({Key? key, required this.tvId}) : super(key: key);
  final int tvId;

  @override
  _TvShowDetailsScreenState createState() =>
      _TvShowDetailsScreenState(tvId: tvId);
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  int tvId;
  var _isInit = true;
  var _isLoading = false;

  _TvShowDetailsScreenState({required this.tvId});

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TvShowsProvider>(context, listen: false)
          .tvShowDetails(tvId: tvId)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Consumer<TvShowsProvider>(builder: (ctx, mProvider, _) {
                String releaseDate = DateFormat('yyyy')
                    .format(mProvider.getTvShowDetails.firstAirDate!);

                return ListView(children: [
                  movieBackdrop(mProvider, context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 8.0, 10.0),
                    child: Text(
                      mProvider.getTvShowDetails.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: Text(releaseDate,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.safeBlockHorizontal * 4)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mProvider.getTvShowDetails.genres.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: kDefaultPadding),
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                  mProvider.getTvShowDetails.genres[index].name,
                                  style: TextStyle(
                                      color: kTextColor.withOpacity(0.8))),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Text('Plot Summary',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Text(mProvider.getTvShowDetails.overview,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal * 4)),
                  ),
                  tvCast(context)
                ]);
              })));
  }

  Container movieBackdrop(TvShowsProvider mProvider, BuildContext context) {
    return Container(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.40,
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: SizeConfig.screenHeight * 0.40 - 50,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(20.0))),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(40.0)),
              child: BlurHash(
                hash: 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.',
                image: 'https://image.tmdb.org/t/p/w780' +
                    mProvider.getTvShowDetails.backdropPath,
                imageFit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 20.0,
              right: 0.0,
              child: Container(
                  height: SizeConfig.screenHeight * 0.08,
                  width: SizeConfig.screenWidth * 0.70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          bottomLeft: Radius.circular(50.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 50,
                            offset: Offset(0, 5),
                            color: Color(0xFF121530).withOpacity(0.2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                                mProvider.getTvShowDetails.voteAverage
                                        .toString() +
                                    ' / 10',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4)),
                          )
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.schedule, color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  mProvider
                                          .getTvShowDetails.episodeRunTime.first
                                          .toString() +
                                      'min /epi',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4)),
                            )
                          ])
                    ],
                  ))),
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: SizeConfig.safeBlockHorizontal * 10),
            ),
          ),
        ]));
  }

  Padding tvCast(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Cast',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: kDefaultPadding / 2),
          Container(
              height: SizeConfig.screenHeight * 0.15,
              //color: Colors.red,
              child: Consumer<TvShowsProvider>(builder: (ctx, mProvider, _) {
                return ListView.builder(
                    itemCount: mProvider.getTvCastLS.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                          width: SizeConfig.screenWidth * 0.20,
                          margin: const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w185' +
                                              mProvider.getTvCastLS[index]
                                                  .profilePath,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.grey,
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.person,
                                              color: Colors.grey,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  10),
                                    ),
                                  ),
                                )),
                            SizedBox(height: kDefaultPadding / 2),
                            Expanded(
                              child: Text(
                                mProvider.getTvCastLS[index].originalName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            )
                          ]));
                    });
              }))
        ]));
  }
}
