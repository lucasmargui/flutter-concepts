import 'package:flutter/material.dart';

void main() {
  runApp(ListasPage());
}

class ListasPage extends StatefulWidget {
  @override
  _ListasPageState createState() => _ListasPageState();
}

class _ListasPageState extends State<ListasPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ListViewWidget(),
    GridViewWidget(),
    ListViewBuilderWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Combined Example'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'ListView',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_on),
              label: 'GridView',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered),
              label: 'ListView.builder',
            ),
          ],
        ),
        floatingActionButton: _currentIndex != 1
            ? FloatingActionButton(
                onPressed: () async {
                  final newItem = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItemScreen()),
                  );
                  if (newItem != null) {
                    if (_currentIndex == 0) {
                      // Add item to ListView
                      (ListViewWidget.items as List<ListItem>)
                          .add(ListItem(title: newItem));
                    } else if (_currentIndex == 2) {
                      // Add item to ListView.builder
                      (ListViewBuilderWidget.items as List<ListItem>)
                          .add(ListItem(title: newItem));
                    }
                    setState(() {});
                  }
                },
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class ListItem {
  String title;
  bool isFavorite;

  ListItem({required this.title, this.isFavorite = false});
}

class ListViewWidget extends StatefulWidget {
  static List<ListItem> items = [
    ListItem(title: 'Item 1'),
    ListItem(title: 'Item 2', isFavorite: true),
    ListItem(title: 'Item 3'),
    ListItem(title: 'Item 4', isFavorite: true),
  ];

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ListViewWidget.items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final editedItem = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditItemScreen(item: ListViewWidget.items[index])),
            );
            if (editedItem != null) {
              ListViewWidget.items[index].title = editedItem;
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item edited successfully')));
              setState(() {});
            }
          },
          child: Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              ListViewWidget.items.removeAt(index);
            },
            child: ListTile(
              title: Text(ListViewWidget.items[index].title),
              trailing: IconButton(
                icon: Icon(
                  ListViewWidget.items[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: ListViewWidget.items[index].isFavorite
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  ListViewWidget.items[index].isFavorite =
                      !ListViewWidget.items[index].isFavorite;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        ListViewWidget.items[index].isFavorite
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      ),
    );
  }
}

class ListViewBuilderWidget extends StatefulWidget {
  static List<ListItem> items = [
    ListItem(title: 'Item 1'),
    ListItem(title: 'Item 2', isFavorite: true),
    ListItem(title: 'Item 3'),
    ListItem(title: 'Item 4', isFavorite: true),
  ];

  @override
  State<ListViewBuilderWidget> createState() => _ListViewBuilderWidgetState();
}

class _ListViewBuilderWidgetState extends State<ListViewBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: ListView.builder(
        itemCount: ListViewBuilderWidget.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final editedItem = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditItemScreen(
                        item: ListViewBuilderWidget.items[index])),
              );
              if (editedItem != null) {
                ListViewBuilderWidget.items[index].title = editedItem;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item edited successfully')));
                setState(() {});
              }
            },
            child: Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                ListViewBuilderWidget.items.removeAt(index);
              },
              child: ListTile(
                title: Text(ListViewBuilderWidget.items[index].title),
                trailing: IconButton(
                  icon: Icon(
                    ListViewBuilderWidget.items[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ListViewBuilderWidget.items[index].isFavorite
                        ? Colors.red
                        : null,
                  ),
                  onPressed: () {
                    ListViewBuilderWidget.items[index].isFavorite =
                        !ListViewBuilderWidget.items[index].isFavorite;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ListViewBuilderWidget.items[index].isFavorite
                              ? 'Added to favorites'
                              : 'Removed from favorites',
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddItemScreen extends StatefulWidget {
  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter Item',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _textEditingController.text.trim());
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditItemScreen extends StatefulWidget {
  final ListItem item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Edit Item',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _textEditingController.text.trim());
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
