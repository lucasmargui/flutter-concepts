import 'package:flutter/material.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

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
            Text(
              'Exemplo de Texto',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 200,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Container',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                print('Botão pressionado!');
              },
              child: Text('Botão'),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Expanded Widget',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FlutterLogo(size: 100),
            SizedBox(height: 10.0),
            Slider(
              value: 0.5,
              onChanged: (double value) {
                print('Valor do Slider: $value');
              },
            ),
            SizedBox(height: 10.0),
            Checkbox(
              value: true,
              onChanged: (bool? value) {
                print('Valor do Checkbox: $value');
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite algo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
              value: 'Opção 1',
              items: <String>['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                print('Nova opção selecionada: $newValue');
              },
            ),
          ],
        ),
      ),
    );
  }
}
