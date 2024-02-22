import 'package:flutter/material.dart';

class NavegacaoExemplo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? data = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data ?? 'No data received'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Data from SecondPage');
              },
              child: Text('Send Data Back'),
            ),
          ],
        ),
      ),
    );
  }
}
