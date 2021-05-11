import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr_weather/viewmodels/weather_view_model.dart';

class SonGuncellemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherViewModel=Provider.of<WeatherViewModel>(context);
    var yeniTarih=_weatherViewModel.getirilenWeather.time.toLocal();
    return Text(
      "Son Guncelleme " + TimeOfDay.fromDateTime(yeniTarih).format(context),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
