import 'package:flutter/material.dart';
import 'package:flutter_conceitos_basicos/animacoes/animacoes_page_1.dart';
import 'package:flutter_conceitos_basicos/animacoes/animacoes_page_2.dart';
import 'package:flutter_conceitos_basicos/animacoes/animacoes_page_3.dart';
import 'package:flutter_conceitos_basicos/animacoes/animacoes_page_4.dart';

class AnimacoesPage extends StatefulWidget {
  @override
  _AnimacoesPageState createState() => _AnimacoesPageState();
}

class _AnimacoesPageState extends State<AnimacoesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TabBar Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Exemplo 1'),
            Tab(text: 'Exemplo 2'),
            Tab(text: 'Exemplo 3'),
            Tab(text: 'Exemplo 4'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: AnimacoesPage1(),
          ),
          Center(
            child: AnimacoesPage2(),
          ),
          Center(
            child: AnimacoesPage3(),
          ),
          Center(
            child: AnimacoesPage4(),
          ),
        ],
      ),
    );
  }
}
