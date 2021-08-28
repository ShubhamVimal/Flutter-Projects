import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_app/provider/ConnectivityChangeNotifier.dart';
import 'package:flutter_movies_app/provider/MoviesProvider.dart';
import 'package:flutter_movies_app/provider/TvShowsProivder.dart';
import 'package:flutter_movies_app/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) {
        ConnectivityChangeNotifier changeNotifier =
            ConnectivityChangeNotifier();
        //Inital load is an async function, can use FutureBuilder to show loading
        //screen while this function running. This is not covered in this tutorial
        changeNotifier.initialLoad();
        return changeNotifier;
      }),
      ChangeNotifierProvider(create: (ctx) => MoviesProvider()),
      ChangeNotifierProvider(create: (ctx) => TvShowsProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'ArimaMadurai',
        primarySwatch: Colors.blue,
      ),
      home: Consumer<ConnectivityChangeNotifier>(
        builder: (ctx, mConnect, _) {
          return mConnect.isConnected
              ? HomeScreen()
              : Scaffold(
                  body: SafeArea(
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Please check your Internet Connection'),
                        Icon(Icons.warning, color: Colors.amber)
                      ],
                    )),
                  ),
                );
        },
      ),
    );
  }
}
