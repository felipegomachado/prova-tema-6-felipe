import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/disciplina.dart';

class DisciplinaEditScreen extends StatefulWidget {
  final Disciplina disciplina;

  DisciplinaEditScreen({required this.disciplina});

  @override
  _DisciplinaEditScreenState createState() => _DisciplinaEditScreenState();
}

class _DisciplinaEditScreenState extends State<DisciplinaEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String nome;

  @override
  void initState() {
    super.initState();
    nome = widget.disciplina.nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplina.id == 0 ? 'Adicionar Disciplina' : 'Editar Disciplina'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final disciplina = Disciplina(
                      id: widget.disciplina.id,
                      nome: nome,
                    );
                    if (widget.disciplina.id == 0) {
                      await ApiService().createDisciplina(disciplina);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.disciplina.id == 0 ? 'Adicionar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
