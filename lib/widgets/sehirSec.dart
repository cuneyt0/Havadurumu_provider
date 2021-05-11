import 'package:flutter/material.dart';
import 'package:providerr_weather/widgets/weatherApp.dart';


class SehirSecWidget extends StatefulWidget {
  @override
  _SehirSecWidgetState createState() => _SehirSecWidgetState();
}

class _SehirSecWidgetState extends State<SehirSecWidget> {
  final _textEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Şehir Seç"),
        ),
        body: Form(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _textEditController,
                    decoration: InputDecoration(
                        labelText: "Şehir Seç",
                        hintText: "Şehir Seç",
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.search),
                  onPressed: ()=>Navigator.pop(context,_textEditController.text),
                ),
              ),
            ],
          ),
        ));
  }
}
