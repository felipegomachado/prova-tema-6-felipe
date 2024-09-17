import 'package:flutter/material.dart';
import 'package:frontend/models/curso.dart'; // Importando o modelo Curso
import 'package:frontend/screens/curso_detail_screen.dart';
import 'screens/curso_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curso CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CursoListScreen(),
      routes: {
        '/cursoDetail': (context) => CursoDetailScreen(curso: ModalRoute.of(context)!.settings.arguments as Curso),
      },
    );
  }
}
