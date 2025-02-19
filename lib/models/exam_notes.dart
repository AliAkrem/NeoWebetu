class ExamNotes {
  final String labelAr;
  final String labelFr;
  final int id;
  final int idDia;
  final double note;
  final int coefficient;
  final int periodId;

  ExamNotes({
    required this.labelAr,
    required this.labelFr,
    required this.id,
    required this.idDia,
    required this.note,
    required this.coefficient,
    required this.periodId,
  });

  factory ExamNotes.fromJson(Map<String, dynamic> json) {
    return ExamNotes(
      labelAr: json['mcLibelleAr'] as String,
      labelFr: json['mcLibelleFr'] as String,
      id: json['id'] as int,
      idDia: json['id_dia'] as int,
      note: (json['noteExamen'] ?? -1 as num).toDouble(),
      coefficient: json['rattachementMcCoefficient'] as int,
      periodId: json['idPeriode'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mcLibelleAr': labelAr,
      'mcLibelleFr': labelFr,
      'id': id,
      'id_dia': idDia,
      'noteExamen': note,
      'rattachementMcCoefficient': coefficient,
      'idPeriode': periodId
    };
  }
}
