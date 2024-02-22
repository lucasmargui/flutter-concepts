import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenciaPage extends StatefulWidget {
  @override
  _PersistenciaPageState createState() => _PersistenciaPageState();
}

class _PersistenciaPageState extends State<PersistenciaPage> {
  TextEditingController _itemController = TextEditingController();
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // Carregar itens armazenados anteriormente
  _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList('items') ?? [];
    });
  }

  // Adicionar um novo item à lista e persistir os itens
  _addItem(String item) async {
    setState(() {
      _items.add(item);
    });
    _saveItems();
  }

  // Remover um item da lista e persistir os itens
  _removeItem(int index) async {
    setState(() {
      _items.removeAt(index);
    });
    _saveItems();
  }

  // Salvar os itens usando SharedPreferences
  _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', _items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Advanced Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: InputDecoration(labelText: 'Digite um item'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_itemController.text.isNotEmpty) {
                      _addItem(_itemController.text);
                      _itemController.clear();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
