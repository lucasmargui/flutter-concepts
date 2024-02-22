// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_conceitos_basicos/animacoes/animacoes_page.dart';
import 'package:flutter_conceitos_basicos/apis/apiPage.dart';
import 'package:flutter_conceitos_basicos/estado/estado-page.dart';
import 'package:flutter_conceitos_basicos/eventos/eventos_page.dart';
import 'package:flutter_conceitos_basicos/internacionalizacao/appLocale.dart';
import 'package:flutter_conceitos_basicos/internacionalizacao/internacionalizacao_page.dart';
import 'package:flutter_conceitos_basicos/layout/layout_page.dart';
import 'package:flutter_conceitos_basicos/listas/listas_page.dart';
import 'package:flutter_conceitos_basicos/models/route_model.dart';
import 'package:flutter_conceitos_basicos/navegacao/navegacao_page.dart';
import 'package:flutter_conceitos_basicos/navegacao/navegacao_page_2.dart';
import 'package:flutter_conceitos_basicos/navegacao/navegacao_page_3.dart';
import 'package:flutter_conceitos_basicos/persistencia/persistenciaPage.dart';
import 'package:flutter_conceitos_basicos/temas/temas_page.dart';
import 'package:flutter_conceitos_basicos/widgets/widgets-page.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ja', AppLocale.JA),
        const MapLocale('br', AppLocale.BR),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ListView de Temas',
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/widgets': (context) => WidgetPage(),
        '/estado': (context) => EstadoPage(),
        '/navegacao': (context) => NavegacaoPage(),
        '/navegacao_page_2': (context) => NavegacaoExemplo2(),
        '/navegacao_page_3': (context) => NavegacaoExemplo3(),
        '/listas': (context) => ListasPage(),
        '/apis': (context) => ApiPage(),
        '/persistencia': (context) => PersistenciaPage(),
        '/temas': (context) => TemaPage(),
        '/eventos': (context) => EventosPage(),
        '/animacoes': (context) => AnimacoesPage(),
        '/layout': (context) => LayoutPage(),
        '/internacionalizacao': (context) => InternacionalizacaoPage(
              localization: localization,
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<RotaNome> temas = [
    RotaNome(rota: 'widgets', descricao: 'Widgets e Elementos Fundamentais'),
    RotaNome(rota: 'estado', descricao: 'Gerenciamento de Estado'),
    RotaNome(rota: 'navegacao', descricao: 'Navegação'),
    RotaNome(rota: 'listas', descricao: 'Listas e Grade de Visualização'),
    RotaNome(rota: 'apis', descricao: 'APIs e Requisições HTTP'),
    RotaNome(rota: 'persistencia', descricao: 'Persistência de Dados'),
    RotaNome(rota: 'temas', descricao: 'Temas e Estilos'),
    RotaNome(rota: 'eventos', descricao: 'Tratamento de Eventos'),
    RotaNome(rota: 'animacoes', descricao: 'Animações'),
    RotaNome(rota: 'layout', descricao: 'Layout Responsivo'),
    RotaNome(
        rota: 'internacionalizacao',
        descricao: 'Internacionalização e Localização'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      body: ListView.builder(
        itemCount: temas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/${temas[index].rota}');
              },
              child: Text(temas[index].descricao),
            ),
          );
        },
      ),
    );
  }
}
