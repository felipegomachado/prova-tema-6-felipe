class Curso {
  final int id;
  final String nome;
  final int cargaHoraria;
  final DateTime dataInicio;

  Curso({
    required this.id,
    required this.nome,
    required this.cargaHoraria,
    required this.dataInicio,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nome: json['nome'],
      cargaHoraria: json['cargaHoraria'],
      dataInicio: DateTime.parse(json['dataInicio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cargaHoraria': cargaHoraria,
      'dataInicio': dataInicio.toIso8601String(),
    };
  }
}
