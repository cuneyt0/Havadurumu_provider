import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr_weather/viewmodels/mthemeview_model.dart';
import 'package:providerr_weather/viewmodels/weather_view_model.dart';
import 'package:providerr_weather/widgets/gecisli_arka_plan.dart';
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
            ? HavaDurumuGeldi()
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? havaDurumuGeliyor()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? havaDurumuGetirHata()
                    : Text("Sehir Seç"),
      ),
    );
  }

  havaDurumuGeliyor() {
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    return Text("Hava durumu getirilirken hata oluştu");
  }
}

class HavaDurumuGeldi extends StatefulWidget {
  @override
  _HavaDurumuGeldiState createState() => _HavaDurumuGeldiState();
}

class _HavaDurumuGeldiState extends State<HavaDurumuGeldi> {
  late WeatherViewModel _weatherViewModel;
  Completer<void> _refresIndicator = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresIndicator = Completer<void>();
    debugPrint("init state tetiklendi");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var kisaltma = Provider.of<WeatherViewModel>(context, listen: false)
          .havaDurumuKisaltmasi();
      debugPrint("kisaltma kodu:" + kisaltma);
      Provider.of<MyThemeViewModel>(context, listen: false)
          .temaDegistir(kisaltma);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("widget build tetiklendi");
    _refresIndicator.complete();
    _refresIndicator = Completer<void>();
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    String kSecilenSehir = _weatherViewModel.getirilenWeather.title;

    return GecisliRenkContainer(
      renk: Provider.of<MyThemeViewModel>(context).myTheme.renk,
      child: RefreshIndicator(
        onRefresh: () {
          _weatherViewModel.havaDurumunuGuncelle(kSecilenSehir);
          return _refresIndicator.future;
        },
        child: ListView(
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
        ),
      ),
    );
  }
}
