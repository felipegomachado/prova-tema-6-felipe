class Curso {
  final int id;
  final String nome;
  final int cargaHoraria;
  final String dataInicio;

  Curso({required this.id, required this.nome, required this.cargaHoraria, required this.dataInicio});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nome: json['nome'],
      cargaHoraria: json['carga_horaria'],
      dataInicio: json['data_inicio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'carga_horaria': cargaHoraria,
      'data_inicio': dataInicio,
    };
  }
}
