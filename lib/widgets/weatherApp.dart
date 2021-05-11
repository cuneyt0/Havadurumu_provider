import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr_weather/viewmodels/weather_view_model.dart';
import 'Location.dart';
import 'sehirSec.dart';
import 'sonGuncelleme.dart';
import 'havaDurumuWidget.dart';
import 'maxMinSicaklikWidget.dart';

class WeatherApp extends StatelessWidget {
  String kSecilenSehir = "Paris";
  late WeatherViewModel _weatherViewModel;

  @override
  Widget build(BuildContext context) {
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            onPressed: () async {
              kSecilenSehir = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SehirSecWidget(),
                ),
              );
              print(kSecilenSehir.toString());
              _weatherViewModel.havaDurumunuGetir(kSecilenSehir);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: (_weatherViewModel.state == WeatherState.WeatherLoadedState)
            ? havaDurumuGeldi()
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? havaDurumuGeliyor()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? havaDurumuGetirHata()
                    : Text("Sehir Seç"),
      ),
    );
  }

  ListView havaDurumuGeldi() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: LocationWidget(
            secilenSehir: kSecilenSehir,
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: SonGuncellemeWidget()),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: HavaDurumuWidget()),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: MaxMinSicaklikWidget(
            bugunundegerleri:
                _weatherViewModel.getirilenWeather.consolidatedWeather[0],
          )),
        ),
      ],
    );
  }

  havaDurumuGeliyor() {
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    return Text("Hava durumu getirilirken hata oluştu");
  }
}
