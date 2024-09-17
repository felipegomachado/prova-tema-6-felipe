import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/curso.dart';
import '../models/disciplina.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  Future<List<Curso>> getCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/cursos'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((curso) => Curso.fromJson(curso)).toList();
    } else {
      throw Exception('Failed to load cursos');
    }
  }

  Future<Curso> getCurso(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/cursos/$id'));

    if (response.statusCode == 200) {
      return Curso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load curso');
    }
  }

  Future<void> createCurso(Curso curso) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cursos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(curso.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create curso');
    }
  }

  Future<void> updateCurso(Curso curso) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cursos/${curso.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(curso.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update curso');
    }
  }

  Future<void> deleteCurso(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/cursos/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete curso');
    }
  }

  Future<List<Disciplina>> getDisciplinas() async {
    final response = await http.get(Uri.parse('$baseUrl/disciplinas'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((disciplina) => Disciplina.fromJson(disciplina)).toList();
    } else {
      throw Exception('Failed to load disciplinas');
    }
  }

  Future<void> createDisciplina(Disciplina disciplina) async {
    final response = await http.post(
      Uri.parse('$baseUrl/disciplinas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(disciplina.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create disciplina');
    }
  }
}
