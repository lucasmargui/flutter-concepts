// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart'; // Importa o pacote de material Flutter
import 'dart:math'; // Importa o pacote de matemática para usar o valor de pi

class AnimacoesPage3 extends StatefulWidget {
  // Widget de página de animações, é um StatefulWidget
  @override
  _AnimacoesPage3State createState() =>
      _AnimacoesPage3State(); // Cria o estado mutável da página de animações
}

class _AnimacoesPage3State
    extends State<AnimacoesPage3> // Estado da página de animações
    with
        SingleTickerProviderStateMixin {
  // Permite que o estado forneça um ticker único para o AnimationController
  late AnimationController _controller; // Controlador de animação
  late Animation<double> _sizeAnimation; // Animação para tamanho
  late Animation<double> _rotationAnimation; // Animação para rotação
  late Animation<Color?> _colorAnimation; // Animação para cor
  double _opacity = 1.0; // Opacidade inicial
  double _scale = 1.0; // Escala inicial

  @override
  void initState() {
    // Inicializa o estado
    super.initState();
    _controller = AnimationController(
      // Inicializa o controlador de animação
      vsync: this, // Usa o mixin SingleTickerProviderStateMixin para o ticker
      duration: Duration(seconds: 1), // Define a duração da animação
    );

    _sizeAnimation = Tween<double>(
      // Animação de tamanho
      begin: 100,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _rotationAnimation = Tween<double>(
      // Animação de rotação (não utilizada no código)
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      // Animação de cor
      begin: Colors.blue,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _controller.repeat(reverse: true); // Repete a animação invertendo-a
  }

  @override
  void dispose() {
    // Descarta o controlador de animação ao finalizar
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Constrói a visualização da página
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Even More Advanced Flutter Animations Example'), // Define o título da barra de aplicativos
      ),
      body: GestureDetector(
        // Widget de detector de gestos
        onVerticalDragUpdate: (details) {
          // Atualização de arrasto vertical
          setState(() {
            _opacity -= details.primaryDelta! /
                1000; // Atualiza a opacidade com base no movimento vertical
            _opacity = _opacity.clamp(0.1,
                1.0); // Limita a opacidade dentro do intervalo de 0.1 a 1.0
          });
        },
        onTap: () {
          // Quando o usuário toca na tela
          setState(() {
            _scale = 1.2; // Define a escala para 1.2
          });
          Future.delayed(Duration(milliseconds: 300), () {
            // Aguarda 300 milissegundos
            setState(() {
              _scale = 1.0; // Retorna a escala para 1.0
            });
          });
        },
        child: Center(
          // Define o conteúdo central
          child: AnimatedBuilder(
            // Constrói um widget animado que pode ser reconstruído quando a animação muda
            animation: _controller, // Usa a animação do controlador definida
            builder: (context, child) {
              // Constrói o widget
              return Transform.scale(
                // Aplica uma transformação de escala
                scale: _scale, // Usa o valor de escala definido
                child: Opacity(
                  // Aplica uma opacidade
                  opacity: _opacity, // Usa o valor de opacidade definido
                  child: Container(
                    height: _sizeAnimation
                        .value, // Usa o valor da animação de tamanho para a altura
                    width: _sizeAnimation
                        .value, // Usa o valor da animação de tamanho para a largura
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20), // Define a borda arredondada
                      gradient: LinearGradient(
                        // Define um gradiente de cor
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _colorAnimation.value!,
                          Colors.yellow
                        ], // Usa a cor animada
                      ),
                    ),
                    child: Center(
                      // Centraliza o texto
                      child: Text(
                        'Even More Advanced Animation', // Define o texto
                        style: TextStyle(
                            color: Colors.white), // Define o estilo do texto
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
