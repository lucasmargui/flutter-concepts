import 'package:flutter/material.dart';

class AnimacoesPage1 extends StatefulWidget {
  @override
  _AnimacoesPage1State createState() => _AnimacoesPage1State();
}

class _AnimacoesPage1State extends State<AnimacoesPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controlador de animação
  late Animation<double>
      _sizeAnimation; // Animação para alterar o tamanho do contêiner
  late Animation<double> _rotationAnimation; // Animação para girar o contêiner
  late Animation<double>
      _fadeAnimation; // Animação para controlar a opacidade do contêiner
  late Animation<Color?>
      _colorAnimation; // Animação para alterar a cor do gradiente

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(_controller);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);

    _controller.forward(); // Inicia a animação
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos do controlador de animação
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0); // Inicia a animação a partir do início
  }

  void _stopAnimation() {
    _controller.stop(); // Para a animação
  }

  void _reverseAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse(); // Inverte a animação se estiver completa
    } else {
      _controller.forward(); // Continua a animação se não estiver completa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Flutter Animations Example'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          _controller.value -= details.delta.dy /
              100; // Atualiza o valor da animação com base no movimento do gesto
        },
        onPanEnd: (details) {
          if (_controller.isAnimating ||
              _controller.status == AnimationStatus.completed ||
              _controller.status == AnimationStatus.forward) {
            _controller.fling(
                velocity:
                    1.0); // Faz a animação "fling" (deslizar) com base na velocidade do gesto
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity:
                    _fadeAnimation, // Aplica a animação de opacidade ao filho
                child: RotationTransition(
                  turns:
                      _rotationAnimation, // Aplica a animação de rotação ao filho
                  child: AnimatedBuilder(
                    animation:
                        _sizeAnimation, // Rebuilda o widget quando a animação de tamanho é alterada
                    builder: (BuildContext context, Widget? child) {
                      return Container(
                        height: _sizeAnimation.value,
                        width: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _colorAnimation.value!,
                              Colors.yellow
                            ], // Aplica a animação de gradiente de cor
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Advanced Animation',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _startAnimation, // Inicia a animação
                    child: Text('Start Animation'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopAnimation, // Para a animação
                    child: Text('Stop Animation'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _reverseAnimation, // Inverte a animação
                    child: Text('Reverse Animation'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
