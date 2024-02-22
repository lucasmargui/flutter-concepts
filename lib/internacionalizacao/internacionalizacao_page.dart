// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_conceitos_basicos/internacionalizacao/appLocale.dart';
import 'package:flutter_localization/flutter_localization.dart';

class InternacionalizacaoPage extends StatefulWidget {
  final FlutterLocalization localization;

  const InternacionalizacaoPage({super.key, required this.localization});

  @override
  State<InternacionalizacaoPage> createState() =>
      _InternacionalizacaoPageState();
}

class _InternacionalizacaoPageState extends State<InternacionalizacaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplos de Widgets em Column'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              child: const Text('English'),
              onPressed: () {
                widget.localization.translate('en');
                print(AppLocale.title.getString(context));
              },
            )
          ],
        ),
      ),
    );
  }
}