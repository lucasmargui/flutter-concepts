import 'package:flutter/material.dart';

class NavegacaoExemplo extends StatelessWidget {
  final Function? onGoBack;

  NavegacaoExemplo({this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (onGoBack != null) {
              onGoBack!();
            }
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
