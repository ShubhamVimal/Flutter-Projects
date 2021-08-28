import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/provider/MoviesProvider.dart';
import 'package:flutter_movies_app/screens/MovieDetailScreen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MovieSearchResultScreen extends StatefulWidget {
  MovieSearchResultScreen({Key? key, required this.query}) : super(key: key);
  String query = '';
  @override
  _MovieSearchResultScreenState createState() =>
      _MovieSearchResultScreenState(query: query);
}

class _MovieSearchResultScreenState extends State<MovieSearchResultScreen> {
  var _isInit = true;
  var _isLoading = false;

  ScrollController _scrollController = ScrollController();
  int newPage = 2;
  String query = '';
  _MovieSearchResultScreenState({required this.query});

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MoviesProvider>(context).movieSearch(query: query).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'showing search results for ' + "'$query'",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<MoviesProvider>(builder: (ctx, movieSearchLS, _) {
              return movieSearchLS.getMovieSearch.length > 0
                  ? StaggeredGridView.countBuilder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8.0),
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 12,
                      itemCount: movieSearchLS.getMovieSearch.length,
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(1, index.isEven ? 1.5 : 1.5);
                      },
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MovieDetails(
                                      movieId: movieSearchLS
                                          .getMovieSearch[index].id))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: 'https://image.tmdb.org/t/p/w185' +
                                    movieSearchLS
                                        .getMovieSearch[index].posterPath,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.grey,
                                              value: downloadProgress.progress),
                                        ),
                                errorWidget: (context, url, error) => Center(
                                      child: Text('No preview Available'),
                                    )),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No results found'),
                    );
            }),
    );
  }
}
