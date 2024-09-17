import 'package:flutter/material.dart';
import '../models/disciplina.dart';
import '../services/api_service.dart';

class DisciplinaScreen extends StatefulWidget {
  final int cursoId;

  DisciplinaScreen({required this.cursoId});

  @override
  _DisciplinaScreenState createState() => _DisciplinaScreenState();
}

class _DisciplinaScreenState extends State<DisciplinaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Disciplina"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome da Disciplina"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, insira o nome da disciplina";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          Disciplina novaDisciplina = Disciplina(
                            nome: _nomeController.text,
                            cursoId: widget.cursoId,
                          );

                          try {
                            await ApiService().createDisciplina(novaDisciplina);
                            Navigator.pop(context, true);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Erro ao adicionar disciplina")),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: Text("Adicionar"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
