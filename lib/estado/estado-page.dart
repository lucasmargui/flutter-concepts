// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciamento de Estado',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: EstadoPage(),
    );
  }
}

class EstadoPage extends StatefulWidget {
  @override
  _EstadoPageState createState() => _EstadoPageState();
}

class _EstadoPageState extends State<EstadoPage> {
  int _counter = 0;
  int _maxValue = 100;
  Color _counterColor = Colors.black;
  List<int> _undoStack = [];
  List<int> _redoStack = [];
  Timer? _timer;
  int _incrementStep = 1;

  @override
  void initState() {
    super.initState();
    // A função initState é chamada quando o estado do widget é inicializado.
    // É usado para realizar inicializações que dependem do contexto do widget.
    // Aqui, carregamos o estado do contador salvo ao inicializar o widget.
    _loadCounterState();
  }

  @override
  void dispose() {
    // A função dispose é chamada quando o widget está sendo removido da árvore de widgets.
    // É usado para limpar recursos, como fechamento de streams ou cancelamento de timers.
    // Aqui, cancelamos o timer se estiver ativo para evitar vazamentos de recursos.
    _timer?.cancel();
    super.dispose();
  }

  // setState Função para atualizar o estado do widget.
  // O setState é usado para notificar o Flutter que o estado do widget foi alterado
  // e que a interface do usuário precisa ser reconstruída.

  // Função para incrementar o contador
  void _incrementCounter() {
    setState(() {
      if (_counter < _maxValue) {
        _undoStack.add(_counter);
        _redoStack.clear();
        _counter += _incrementStep;
      }
    });
  }

  // Função para decrementar o contador
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _undoStack.add(_counter);
        _redoStack.clear();
        _counter -= _incrementStep;
      }
    });
  }

  // Função para resetar o contador
  void _resetCounter() {
    setState(() {
      _undoStack.add(_counter);
      _redoStack.clear();
      _counter = 0;
    });
  }

  // Função para definir o valor máximo do contador
  void _setCounterMaxValue(String value) {
    setState(() {
      _maxValue = int.tryParse(value) ?? _maxValue;
    });
  }

  // Função para definir a cor do contador
  void _setCounterColor(Color color) {
    setState(() {
      _counterColor = color;
    });
  }

  // Função para definir um valor aleatório para o contador
  void _setRandomValue() {
    setState(() {
      _undoStack.add(_counter);
      _redoStack.clear();
      _counter = Random().nextInt(_maxValue + 1);
    });
  }

  // Função para incrementar o contador por uma quantidade específica
  void _incrementByAmount(int amount) {
    setState(() {
      if (_counter + amount <= _maxValue) {
        _undoStack.add(_counter);
        _redoStack.clear();
        _counter += amount;
      }
    });
  }

  // Função para desfazer a última operação no contador
  void _undo() {
    setState(() {
      if (_undoStack.isNotEmpty) {
        _redoStack.add(_counter);
        _counter = _undoStack.removeLast();
      }
    });
  }

  // Função para refazer a última operação desfeita no contador
  void _redo() {
    setState(() {
      if (_redoStack.isNotEmpty) {
        _undoStack.add(_counter);
        _counter = _redoStack.removeLast();
      }
    });
  }

  // Função para iniciar a contagem regressiva
  void _startCountdown(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _undoStack.add(_counter);
          _redoStack.clear();
          _counter--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  // Função para pausar a contagem regressiva
  void _pauseCountdown() {
    _timer?.cancel();
  }

  // Função para retomar a contagem regressiva
  void _resumeCountdown() {
    _startCountdown(_counter);
  }

  // Função para salvar o estado atual do contador
  void _saveCounterState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'counter_state',
        jsonEncode({
          'counter': _counter,
          'max_value': _maxValue,
          'color': _counterColor.value,
        }));
  }

  // Função para carregar o estado do contador salvo
  void _loadCounterState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? counterState = prefs.getString('counter_state');
    if (counterState != null) {
      Map<String, dynamic> state = jsonDecode(counterState);
      setState(() {
        _counter = state['counter'];
        _maxValue = state['max_value'];
        _counterColor = Color(state['color']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (_counter / _maxValue).clamp(0, 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciamento de Estado Avançado',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveCounterState,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Contador:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              '$_counter / $_maxValue',
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: _counterColor),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrementar',
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Incrementar',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Definir valor máximo do contador',
                border: OutlineInputBorder(),
              ),
              onChanged: _setCounterMaxValue,
            ),
            SizedBox(height: 20.0),
            ColorPicker(
              labelText: 'Escolher cor do contador',
              initialColor: _counterColor,
              onColorChanged: _setCounterColor,
            ),
            SizedBox(height: 20.0),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
              minHeight: 20.0,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _setRandomValue,
                  child: Text('Valor Aleatório'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () => _incrementByAmount(5),
                  child: Text('Incrementar por 5'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _startCountdown(10),
                  child: Text('Iniciar Contagem Regressiva (10s)'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _pauseCountdown,
                  child: Text('Pausar Contagem Regressiva'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _resumeCountdown,
                  child: Text('Retomar Contagem Regressiva'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _undo,
                  child: Text('Desfazer'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _redo,
                  child: Text('Refazer'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: Text('Resetar Contador'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  final String labelText;
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    required this.labelText,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 10.0),
        GestureDetector(
          onTap: () async {
            Color selectedColor = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Escolher Cor'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: initialColor,
                    onColorChanged: (color) {
                      Navigator.of(context).pop(color);
                    },
                  ),
                ),
              ),
            );
            if (selectedColor != null) {
              onColorChanged(selectedColor);
            }
          },
          child: Container(
            width: 50,
            height: 30,
            color: initialColor,
          ),
        ),
      ],
    );
  }
}
