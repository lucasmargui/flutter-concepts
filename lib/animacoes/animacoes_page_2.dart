import 'package:flutter/material.dart'; // Importa o pacote de material Flutter
import 'dart:math'; // Importa o pacote de matemática para usar o valor de pi

class AnimacoesPage2 extends StatefulWidget {
  // Widget de página de animações, é um StatefulWidget
  @override
  _AnimacoesPage2State createState() =>
      _AnimacoesPage2State(); // Cria o estado mutável da página de animações
}

class _AnimacoesPage2State
    extends State<AnimacoesPage2> // Estado da página de animações
    with
        SingleTickerProviderStateMixin {
  // Permite que o estado forneça um ticker único para o AnimationController
  late AnimationController _controller; // Controlador de animação
  late Animation<double> _sizeAnimation; // Animação para tamanho
  late Animation<double> _rotationAnimation; // Animação para rotação
  late Animation<double> _fadeAnimation; // Animação para opacidade
  late Animation<Color?> _colorAnimation; // Animação para cor
  late Animation<Offset> _positionAnimation; // Animação para posição

  @override
  void initState() {
    // Inicializa o estado
    super.initState();
    _controller = AnimationController(
      // Inicializa o controlador de animação
      vsync: this, // Usa o mixin SingleTickerProviderStateMixin para o ticker
      duration: Duration(seconds: 3), // Define a duração da animação
    );

    _sizeAnimation = Tween<double>(
      // Animação de tamanho
      begin: 0,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(
      // Animação de rotação
      begin: 0,
      end: 2 *
          pi, // Utiliza o valor de pi para representar uma volta completa (360 graus)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      // Animação de opacidade
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
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

    _positionAnimation = Tween<Offset>(
      // Animação de posição
      begin: Offset(0, 0),
      end: Offset(200, 200),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
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

  void _startAnimation() {
    // Inicia a animação
    _controller.forward(from: 0.0);
  }

  void _stopAnimation() {
    // Para a animação
    _controller.stop();
  }

  void _reverseAnimation() {
    // Inverte a animação
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Constrói a visualização da página
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Very Advanced Flutter Animations Example'), // Define o título da barra de aplicativos
      ),
      body: Center(
        // Define o corpo central da página
        child: Stack(
          // Empilha widgets uns sobre os outros
          children: [
            Positioned(
              // Posiciona um widget em relação ao pai
              left: _positionAnimation.value.dx, // Posição horizontal
              top: _positionAnimation.value.dy, // Posição vertical
              child: FadeTransition(
                // Adiciona uma transição de opacidade
                opacity: _fadeAnimation, // Usa a animação de opacidade definida
                child: RotationTransition(
                  // Adiciona uma transição de rotação
                  turns:
                      _rotationAnimation, // Usa a animação de rotação definida
                  child: AnimatedBuilder(
                    // Constrói um widget animado que pode ser reconstruído quando a animação muda
                    animation:
                        _sizeAnimation, // Usa a animação de tamanho definida
                    builder: (BuildContext context, Widget? child) {
                      // Constrói o widget
                      return Container(
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
                            'Very Advanced Animation', // Define o texto
                            style: TextStyle(
                                color:
                                    Colors.white), // Define o estilo do texto
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        // Define uma coluna de botões flutuantes
        mainAxisAlignment: MainAxisAlignment
            .end, // Alinha os botões flutuantes ao final da tela
        crossAxisAlignment:
            CrossAxisAlignment.end, // Alinha os botões flutuantes à direita
        children: [
          FloatingActionButton(
            // Botão flutuante para iniciar a animação
            onPressed: _startAnimation,
            tooltip: 'Start Animation',
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(height: 10), // Adiciona um espaço entre os botões
          FloatingActionButton(
            // Botão flutuante para parar a animação
            onPressed: _stopAnimation,
            tooltip: 'Stop Animation',
            child: Icon(Icons.stop),
          ),
          SizedBox(height: 10), // Adiciona um espaço entre os botões
          FloatingActionButton(
            // Botão flutuante para inverter a animação
            onPressed: _reverseAnimation,
            tooltip: 'Reverse Animation',
            child: Icon(Icons.autorenew),
          ),
        ],
      ),
    );
  }
}
