import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      )
  );

  //Setting the orientation to portrait.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rathumakara FM",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(210, 0, 0, 1),
        splashColor: Colors.transparent,
        canvasColor: Color.fromRGBO(20,29, 40, 1),
        primarySwatch: Colors.red,
        sliderTheme: SliderThemeData(
          trackHeight: 2,
          thumbShape: RoundSliderThumbShape(
            disabledThumbRadius: 6,
            enabledThumbRadius: 6,
          )
        )
      ),
      home: MainScreen(),
    );
  }
}