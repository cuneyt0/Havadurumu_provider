import 'package:flutter/material.dart';
import 'package:providerr_weather/locator.dart';
import 'package:providerr_weather/viewmodels/mthemeview_model.dart';
import 'package:providerr_weather/viewmodels/weather_view_model.dart';

import 'widgets/weatherApp.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(ChangeNotifierProvider(
      create: (context) => MyThemeViewModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, MyThemeViewModel myThemeViewModel, child) =>
          MaterialApp(
              title: 'WeatherApp Provider',
              debugShowCheckedModeBanner: false,
              theme: myThemeViewModel.myTheme.tema,
              home: ChangeNotifierProvider<WeatherViewModel>(
                create: (context) => locator<WeatherViewModel>(),
                child: WeatherApp(),
              )),
    );
  }
}
