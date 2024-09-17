import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../services/api_service.dart';

class CursoListScreen extends StatefulWidget {
  @override
  _CursoListScreenState createState() => _CursoListScreenState();
}

class _CursoListScreenState extends State<CursoListScreen> {
  late Future<List<Curso>> _futureCursos;

  @override
  void initState() {
    super.initState();
    _futureCursos = ApiService().getCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Cursos"),
      ),
      body: FutureBuilder<List<Curso>>(
        future: _futureCursos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar cursos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum curso encontrado"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final curso = snapshot.data![index];
                return ListTile(
                  title: Text(curso.nome),
                  subtitle: Text("Carga Horária: ${curso.cargaHoraria} horas"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/cursoDetail',
                      arguments: curso,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
