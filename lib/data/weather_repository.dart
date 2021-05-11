
import 'package:providerr_weather/data/weather_api_client.dart';
import 'package:providerr_weather/locator.dart';

import '../model/model.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async {
    final int sehirID = await weatherApiClient.getLocationID(sehir);
    return await weatherApiClient.getWeather(sehirID);
  }
}