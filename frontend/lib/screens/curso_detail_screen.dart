import 'package:flutter/material.dart';
import '../models/curso.dart';

class CursoDetailScreen extends StatelessWidget {
  final Curso curso;

  CursoDetailScreen({required this.curso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curso.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${curso.nome}', style: TextStyle(fontSize: 20)),
            Text('Carga Horária: ${curso.cargaHoraria} horas', style: TextStyle(fontSize: 18)),
            Text('Data de Início: ${curso.dataInicio.toLocal()}'.split(' ')[0], style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
