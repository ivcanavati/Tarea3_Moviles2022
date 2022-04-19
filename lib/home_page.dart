import 'dart:html';

import 'package:donativos/donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentSelectedRadio;
  var assetsRadioGroup = {
    0: "assets/paypal_logo.png",
    1: "assets/creditcard_logo.png",
  };
  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };

  double _value = 0;
  double _paypal = 0;
  double _tarjeta = 0;
  String dropdownValue = '100';
  double _progress = 0;

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioItem) => ListTile(
            leading: Image.asset(
              assetsRadioGroup[radioItem.key]!,
              height: 64,
              width: 44,
            ),
            title: Text("${radioItem.value}"),
            trailing: Radio(
              value: radioItem.key,
              groupValue: currentSelectedRadio,
              onChanged: (int? newSelectedRadio) {
                currentSelectedRadio = newSelectedRadio;
                setState(() {});
              },
            ),
          ),
        )
        .toList();
  }

  dropDownItemsGenerator() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['100', '350', '1050', '9999']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void calcularDonaciones() {
    if (currentSelectedRadio == 0) {
      _paypal = _paypal + double.parse(dropdownValue);
    } else {
      _tarjeta = _tarjeta + double.parse(dropdownValue);
    }
    _value = _paypal + _tarjeta;
    if (_value < 10000) {
      _progress = _value / 10000;
    } else {
      _progress = 1;
    }
    print(_progress.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            // Radios paypal y tarjeta
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            ),
            ListTile(
                title: Text("Cantidad a donar:"),
                trailing: dropDownItemsGenerator()),
            Stack(
              children: [
                LinearProgressIndicator(
                  minHeight: 20,
                  value: _progress,
                ),
                Positioned(
                    child: Center(
                        child:
                            Text((_progress * 100).toStringAsFixed(2) + "%")))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (currentSelectedRadio == 0 || currentSelectedRadio == 1) {
                  setState(() {
                    calcularDonaciones();
                  });
                }
              },
              child: const Text("DONAR"),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        tooltip: "Ver donativos",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donativos(
                donativos: {
                  "paypal": _paypal,
                  "tarjeta": _tarjeta,
                  "acumulado": _value
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
