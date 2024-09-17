class Disciplina {
  int? id;
  String nome;
  int cursoId;

  Disciplina({this.id, required this.nome, required this.cursoId});

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
      cursoId: json['curso_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'curso_id': cursoId,
    };
  }
}
