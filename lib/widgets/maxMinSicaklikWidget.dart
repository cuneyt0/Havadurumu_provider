import 'package:flutter/material.dart';

class MaxMinSicaklikWidget extends StatelessWidget {

  var bugunundegerleri;
  MaxMinSicaklikWidget({this.bugunundegerleri});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Max Sıcaklık:" + bugunundegerleri.maxTemp.floor().toString(),
          style: TextStyle(fontSize: 20),
        ),
        Text("Min Sıcaklık:" + bugunundegerleri.minTemp.floor().toString(), style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
