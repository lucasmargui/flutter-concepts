import 'dart:convert'; // Importação da biblioteca para lidar com codificação e decodificação de JSON.
import 'package:flutter/material.dart'; // Importação do pacote flutter material para construir a interface do aplicativo.
import 'package:http/http.dart'
    as http; // Importação do pacote http para fazer requisições HTTP.

void main() {
  runApp(ApiPage()); // Inicialização do aplicativo Flutter.
}

class ApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Pagination Example', // Título do aplicativo.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Definição da cor primária do tema.
      ),
      home: MyHomePage(), // Definição da página inicial do aplicativo.
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Map<String, dynamic>> _data; // Lista de dados recebidos da API.
  bool _isLoading = false; // Indica se a página está carregando.
  int _currentPage = 1; // Página atual dos dados.

  @override
  void initState() {
    super.initState();
    _data = []; // Inicialização da lista de dados.
    fetchData(); // Carrega os dados iniciais.
  }

  // Função assíncrona para buscar dados da API.
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Define que está carregando.
    });

    final String apiUrl =
        'https://jsonplaceholder.typicode.com/posts?_page=$_currentPage&_limit=10';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> newData =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        setState(() {
          _data.addAll(newData); // Adiciona os novos dados à lista existente.
          _isLoading = false; // Define que terminou de carregar.
        });
      } else {
        setState(() {
          _isLoading = false; // Define que terminou de carregar.
        });
        // Handle error
      }
    } catch (error) {
      setState(() {
        _isLoading = false; // Define que terminou de carregar.
      });
      // Handle error
    }
  }

  // Função assíncrona para carregar mais dados.
  Future<void> loadMoreData() async {
    _currentPage++; // Incrementa a página.
    await fetchData(); // Carrega os novos dados.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('HTTP Pagination Example'), // Título da barra de aplicativos.
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator()) // Indicador de carregamento.
          : ListView.builder(
              itemCount: _data.length + 1,
              itemBuilder: (context, index) {
                if (index < _data.length) {
                  return ListTile(
                    title:
                        Text(_data[index]['title']), // Título do item da lista.
                    subtitle: Text(
                        _data[index]['body']), // Subtítulo do item da lista.
                  );
                } else {
                  return _isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator()) // Indicador de carregamento.
                      : ListTile(
                          title: Text(
                              'Carregar mais'), // Texto para carregar mais dados.
                          onTap:
                              loadMoreData, // Função para carregar mais dados quando pressionado.
                        );
                }
              },
            ),
    );
  }
}
