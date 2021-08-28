import 'package:flutter/material.dart';
import 'package:flutter_movies_app/provider/ConnectivityChangeNotifier.dart';
import 'package:flutter_movies_app/widgets/Movies.dart';
import 'package:flutter_movies_app/widgets/TvShows.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Movies(),
    TvShows(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Consumer<ConnectivityChangeNotifier>(
        builder: (ctx, mConnect, _) {
          return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.movie), label: 'Movies'),
                BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV'),
              ],
              selectedItemColor: Color(0xFF6200EE),
              unselectedItemColor: Colors.grey.withOpacity(.60),
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              iconSize: 40,
              onTap: _onItemTapped,
              elevation: 5);
        },
      ),
    );
  }
}

// Scaffold(
//             body: Center(
//                 child:
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text('Please check your internet connection '),
//             Icon(Icons.warning, color: Colors.amber)
//           ])))