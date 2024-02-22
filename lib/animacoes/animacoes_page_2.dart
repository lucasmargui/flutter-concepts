import 'package:flutter/material.dart';
import 'dart:math';

class AnimacoesPage2 extends StatefulWidget {
  @override
  _AnimacoesPage2State createState() => _AnimacoesPage2State();
}

class _AnimacoesPage2State extends State<AnimacoesPage2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(200, 200),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  void _stopAnimation() {
    _controller.stop();
  }

  void _reverseAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Very Advanced Flutter Animations Example'),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: _positionAnimation.value.dx,
              top: _positionAnimation.value.dy,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: AnimatedBuilder(
                    animation: _sizeAnimation,
                    builder: (BuildContext context, Widget? child) {
                      return Container(
                        height: _sizeAnimation.value,
                        width: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_colorAnimation.value!, Colors.yellow],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Very Advanced Animation',
                            style: TextStyle(color: Colors.white),
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _startAnimation,
            tooltip: 'Start Animation',
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _stopAnimation,
            tooltip: 'Stop Animation',
            child: Icon(Icons.stop),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _reverseAnimation,
            tooltip: 'Reverse Animation',
            child: Icon(Icons.autorenew),
          ),
        ],
      ),
    );
  }
}
