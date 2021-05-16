import 'package:flutter/material.dart';
import 'package:providerr_weather/data/weather_repository.dart';

import '../locator.dart';
import '../model/model.dart';

enum WeatherState {
  InitialWeatherState,
  WeatherLoadingState,
  WeatherLoadedState,
  WeatherErrorState
}

class WeatherViewModel with ChangeNotifier {
  late WeatherState _state;
  WeatherRepository _repository = locator<WeatherRepository>();
  late Weather _getirilenWeather;

  WeatherViewModel() {
    _getirilenWeather = Weather();
    _state = WeatherState.InitialWeatherState;
  }

  Weather get getirilenWeather => _getirilenWeather;

  WeatherState get state => _state;

  set state(WeatherState value) {
    _state = value;
    notifyListeners();
  }

  Future<Weather> havaDurumunuGetir(String sehirAdi) async {
    try {
      state = WeatherState.WeatherLoadingState;
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state = WeatherState.WeatherLoadedState;
    } catch (e) {
      state = WeatherState.WeatherErrorState;
    }
    return _getirilenWeather;
  }

  Future<Weather> havaDurumunuGuncelle(String sehirAdi) async {
    try {
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state = WeatherState.WeatherLoadedState;
    } catch (e) {}
    return _getirilenWeather;
  }
  String havaDurumuKisaltmasi(){
    return getirilenWeather.consolidatedWeather[0].weatherStateAbbr;


  }
}
