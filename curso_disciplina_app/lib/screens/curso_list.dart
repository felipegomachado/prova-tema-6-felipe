import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/curso.dart';

class CursoList extends StatefulWidget {
  @override
  _CursoListState createState() => _CursoListState();
}

class _CursoListState extends State<CursoList> {
  late Future<List<Curso>> futureCursos;

  @override
  void initState() {
    super.initState();
    futureCursos = ApiService().getCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cursos'),
      ),
      body: FutureBuilder<List<Curso>>(
        future: futureCursos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final curso = snapshot.data![index];
                return ListTile(
                  title: Text(curso.nome),
                  subtitle: Text('Carga Horária: ${curso.cargaHoraria}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CursoEditScreen(curso: curso),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CursoEditScreen(curso: Curso(id: 0, nome: '', cargaHoraria: 0, dataInicio: '')),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
