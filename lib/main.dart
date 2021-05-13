import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'launch_list.dart';
import 'launch_data_store.dart';
import 'launch_search.dart';

void main() {
  runApp(SpaceLaunchApp());
}

class SpaceLaunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LaunchDataStore(),
        child: MaterialApp(
          title: "Space Launch",
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color.fromRGBO(28, 42, 64, 1),
            primaryColorDark: Color.fromRGBO(19, 34, 54, 1),
            primaryColorLight: Color.fromRGBO(35, 53, 79, 1),
            accentColor: Color.fromRGBO(237, 124, 102, 1),
            textTheme: TextTheme(
              headline2: TextStyle(fontSize: 24, color: Colors.white),
              headline3: TextStyle(fontSize: 22, color: Colors.white),
              bodyText1: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(172, 188, 215, 1)),
              bodyText2: TextStyle(
                  fontSize: 17, color: Color.fromRGBO(72, 88, 115, 1)),
            ),
          ),
          home: HomeScreen(),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: PageView(scrollDirection: Axis.horizontal, children: [
          LaunchList(),
          LaunchSearch(),
        ]),
      ),
    );
  }
}
