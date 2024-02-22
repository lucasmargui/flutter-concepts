import 'package:flutter/material.dart';
import 'dart:math';

class AnimacoesPage3 extends StatefulWidget {
  @override
  _AnimacoesPage3State createState() => _AnimacoesPage3State();
}

class _AnimacoesPage3State extends State<AnimacoesPage3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  // ignore: unused_field
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;
  double _opacity = 1.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
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

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Even More Advanced Flutter Animations Example'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _opacity -= details.primaryDelta! / 1000;
            _opacity = _opacity.clamp(0.1, 1.0);
          });
        },
        onTap: () {
          setState(() {
            _scale = 1.2;
          });
          Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _scale = 1.0;
            });
          });
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scale,
                child: Opacity(
                  opacity: _opacity,
                  child: Container(
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
                        'Even More Advanced Animation',
                        style: TextStyle(color: Colors.white),
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
