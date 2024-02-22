// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // Importa o pacote de material Flutter

class AnimacoesPage4 extends StatelessWidget {
  const AnimacoesPage4({super.key});
  // Widget de página de animações, é um StatelessWidget
  @override
  Widget build(BuildContext context) {
    // Constrói a visualização da página
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'), // Define o título da barra de aplicativos
      ),
      body: Center(
        child: ElevatedButton(
          // Botão elevado
          onPressed: () {
            // Quando o botão é pressionado
            Navigator.of(context).push(
              // Navega para a próxima página
              PageRouteBuilder(
                // Constrói uma rota personalizada
                transitionDuration: Duration(
                    milliseconds: 500), // Define a duração da transição
                pageBuilder: (_, __, ___) =>
                    SecondPage(), // Constrói a próxima página
                transitionsBuilder: (_, animation, __, child) {
                  // Constrói a animação de transição
                  return FadeTransition(
                    // Transição de fade
                    opacity: animation, // Usa a animação de opacidade
                    child: child, // Usa o filho (a próxima página)
                  );
                },
              ),
            );
          },
          child: Text('Go to Second Page'), // Define o texto do botão
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  // Widget de segunda página, é um StatelessWidget
  @override
  Widget build(BuildContext context) {
    // Constrói a visualização da página
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'), // Define o título da barra de aplicativos
      ),
      body: Center(
        child: ElevatedButton(
          // Botão elevado
          onPressed: () {
            // Quando o botão é pressionado
            Navigator.of(context)
                .pop(); // Fecha a página atual e retorna para a página anterior
          },
          child: Text('Go Back'), // Define o texto do botão
        ),
      ),
    );
  }
}
