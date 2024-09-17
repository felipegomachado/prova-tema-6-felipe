import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/curso.dart';

class CursoEditScreen extends StatefulWidget {
  final Curso curso;

  CursoEditScreen({required this.curso});

  @override
  _CursoEditScreenState createState() => _CursoEditScreenState();
}

class _CursoEditScreenState extends State<CursoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late int cargaHoraria;
  late String dataInicio;

  @override
  void initState() {
    super.initState();
    nome = widget.curso.nome;
    cargaHoraria = widget.curso.cargaHoraria;
    dataInicio = widget.curso.dataInicio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.curso.id == 0 ? 'Adicionar Curso' : 'Editar Curso'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  nome = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: cargaHoraria.toString(),
                decoration: InputDecoration(labelText: 'Carga Horária'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cargaHoraria = int.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: dataInicio,
                decoration: InputDecoration(labelText: 'Data de Início'),
                onChanged: (value) {
                  dataInicio = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final curso = Curso(
                      id: widget.curso.id,
                      nome: nome,
                      cargaHoraria: cargaHoraria,
                      dataInicio: dataInicio,
                    );
                    if (widget.curso.id == 0) {
                      await ApiService().createCurso(curso);
                    } else {
                      await ApiService().updateCurso(curso);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.curso.id == 0 ? 'Adicionar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
