import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ApiPage());
}

class ApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Pagination Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Map<String, dynamic>> _data;
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _data = [];
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl =
        'https://jsonplaceholder.typicode.com/posts?_page=$_currentPage&_limit=10';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> newData =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        setState(() {
          _data.addAll(newData);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        // Handle error
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  Future<void> loadMoreData() async {
    _currentPage++;
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Pagination Example'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length + 1,
              itemBuilder: (context, index) {
                if (index < _data.length) {
                  return ListTile(
                    title: Text(_data[index]['title']),
                    subtitle: Text(_data[index]['body']),
                  );
                } else {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListTile(
                          title: Text('Carregar mais'),
                          onTap: loadMoreData,
                        );
                }
              },
            ),
    );
  }
}
