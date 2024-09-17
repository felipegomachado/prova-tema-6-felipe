import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/curso.dart';
import '../models/disciplina.dart';

class ApiService {
  final String baseUrl = "http://localhost:8080";

  Future<List<Curso>> getCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/cursos'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((curso) => Curso.fromJson(curso)).toList();
    } else {
      throw Exception("Falha ao carregar cursos");
    }
  }

  Future<Curso> createCurso(Curso curso) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cursos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(curso.toJson()),
    );
    if (response.statusCode == 201) {
      return Curso.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao criar curso");
    }
  }

  // Métodos para Disciplina
  Future<List<Disciplina>> getDisciplinas(int cursoId) async {
    final response = await http.get(Uri.parse('$baseUrl/cursos/$cursoId/disciplinas'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((disciplina) => Disciplina.fromJson(disciplina)).toList();
    } else {
      throw Exception("Falha ao carregar disciplinas");
    }
  }

  Future<Disciplina> createDisciplina(Disciplina disciplina) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cursos/${disciplina.cursoId}/disciplinas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(disciplina.toJson()),
    );
    if (response.statusCode == 201) {
      return Disciplina.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao criar disciplina");
    }
  }
}
