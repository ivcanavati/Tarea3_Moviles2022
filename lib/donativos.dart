import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  final donativos;
  Donativos({
    Key? key,
    required this.donativos,
  }) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal_logo.png"),
              trailing: Text(
                "${widget.donativos["paypal"] ?? 0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/creditcard_logo.png"),
              trailing: Text(
                "${widget.donativos["tarjeta"] ?? 0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "${widget.donativos["acumulado"] ?? 0}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            if (double.parse(widget.donativos["acumulado"].toString()) >=
                10000) ...[Container(child: Image.asset('assets/gracias.png'))]
          ],
        ),
      ),
    );
  }
}
