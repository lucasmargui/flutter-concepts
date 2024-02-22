import 'package:flutter/material.dart';

class EventosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced ReorderableListView Example'),
      ),
      body: ItemList(),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final String item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
      children: List.generate(
        items.length,
        (index) {
          return ItemWidget(
            key: ValueKey(items[index]),
            itemText: items[index],
            onLongPress: () {
              _editItem(index);
            },
            onDelete: () {
              _deleteItem(index);
            },
          );
        },
      ),
    );
  }

  void _editItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String newItemText = items[index];
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            onChanged: (value) {
              newItemText = value;
            },
            controller: TextEditingController(text: items[index]),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  items[index] = newItemText;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String itemText;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;

  const ItemWidget({
    Key? key,
    required this.itemText,
    required this.onLongPress,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onLongPress: onLongPress,
      child: Container(
        key: ValueKey(itemText),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemText,
              style: TextStyle(fontSize: 18.0),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
