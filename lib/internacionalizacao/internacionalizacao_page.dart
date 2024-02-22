// ignore_for_file: prefer_const_constructors, avoid_print
// Esta linha evita que o linter sugira usar construtores constantes e desativa os alertas sobre impressões.

import 'package:flutter/material.dart'; // Importa o pacote de material Flutter.
import 'package:flutter_conceitos_basicos/internacionalizacao/appLocale.dart'; // Importa a classe AppLocale para lidar com a internacionalização.
import 'package:flutter_localization/flutter_localization.dart'; // Importa o pacote de localização.

class InternacionalizacaoPage extends StatefulWidget {
  final FlutterLocalization
      localization; // Objeto para lidar com a localização.

  const InternacionalizacaoPage(
      {super.key,
      required this.localization}); // Construtor da página de internacionalização.

  @override
  State<InternacionalizacaoPage> createState() =>
      _InternacionalizacaoPageState(); // Cria o estado da página de internacionalização.
}

class _InternacionalizacaoPageState extends State<InternacionalizacaoPage> {
  String bodytext = 'Default'; // Define o texto do corpo como padrão.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Internacionalização'), // Define o título da barra de aplicativos.
      ),
      body: Padding(
        padding: EdgeInsets.all(
            16.0), // Define o preenchimento ao redor dos elementos do corpo.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              child: const Text('English'), // Botão para selecionar inglês.
              onPressed: () {
                widget.localization.translate('en'); // Traduz para inglês.

                setState(() {
                  bodytext = AppLocale.title
                      .getString(context); // Obtém o texto traduzido.
                });
                print(AppLocale.title
                    .getString(context)); // Exibe o texto traduzido no console.
              },
            ),
            ElevatedButton(
              child:
                  const Text('Português'), // Botão para selecionar português.
              onPressed: () {
                widget.localization.translate('br'); // Traduz para português.
                setState(() {
                  bodytext = AppLocale.title
                      .getString(context); // Obtém o texto traduzido.
                });
                print(AppLocale.title
                    .getString(context)); // Exibe o texto traduzido no console.
              },
            ),
            SizedBox(height: 50.0), // Espaçamento entre os botões e o texto.
            Text(bodytext) // Exibe o texto traduzido.
          ],
        ),
      ),
    );
  }
}
