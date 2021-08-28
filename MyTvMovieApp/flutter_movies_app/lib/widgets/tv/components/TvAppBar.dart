import 'package:flutter/material.dart';
import 'package:flutter_movies_app/screens/TvShowSearchScreen.dart';
import 'package:flutter_movies_app/utility/Size_Config.dart';

import '../../../constants.dart';

class TvAppBar extends StatelessWidget {
  TvAppBar({Key? key}) : super(key: key);

  final TextEditingController _searchTED = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        height: SizeConfig.screenHeight * 0.15,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: Column(
          children: [
            Text('TvShows', style: Theme.of(context).textTheme.headline6),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchTED,
                        decoration: InputDecoration(
                            hintText: 'Search tv shows..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_searchTED.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TvShowSearchScreen(
                                          query: _searchTED.text)));
                              // _searchTED.clear();
                            }
                          },
                          child: Text('Search')),
                    )
                  ]),
            ),
          ],
        ));
  }
}
