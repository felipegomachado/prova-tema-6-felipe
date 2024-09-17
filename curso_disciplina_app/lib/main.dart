import 'package:flutter/material.dart';
import 'screens/curso_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Cursos e Disciplinas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CursoList(),
    );
  }
}
