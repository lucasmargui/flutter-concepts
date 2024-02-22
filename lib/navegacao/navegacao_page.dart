// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_conceitos_basicos/navegacao/navegacao_page_1.dart';

class NavegacaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavegacaoExemplo(
                      ///Passando Função como Parâmetro para segunda pagina
                      onGoBack: () {
                        print('Returned from NavegacaoExemplo');
                      },
                    ),
                  ),
                );
              },
              child: Text('Go to NavegacaoExemplo (push)'),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                    context, '/navegacao_page_2',
                    arguments: 'Hello from NavegacaoPage');
                if (result != null) {
                  print('Received result from SecondPage: $result');
                }
              },
              child: Text('Go to Page NavegacaoExemplo2 (pushNamed)'),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/navegacao_page_3');
              },
              child: Text('Replace with NavegacaoExemplo3 (pushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}
