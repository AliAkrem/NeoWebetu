class AssessmentNote {
  final String apCode;
  final int id;
  final int idDia;
  final String llPeriode;
  final String llPeriodeAr;
  final double note;
  final String observation;
  final String rattachementMcMcLibelleAr;
  final String rattachementMcMcLibelleFr;

  AssessmentNote({
    required this.apCode,
    required this.id,
    required this.idDia,
    required this.llPeriode,
    required this.llPeriodeAr,
    required this.note,
    required this.observation,
    required this.rattachementMcMcLibelleAr,
    required this.rattachementMcMcLibelleFr,
  });

  factory AssessmentNote.fromJson(Map<String, dynamic> json) {
    return AssessmentNote(
      apCode: json['apCode'] ?? '',
      id: json['id'] ?? 0,
      idDia: json['idDia'] ?? 0,
      llPeriode: json['llPeriode'] ?? '',
      llPeriodeAr: json['llPeriodeAr'] ?? '',
      note: json['note']?.toDouble() ?? 0.0,
      observation: json['observation'] ?? '',
      rattachementMcMcLibelleAr: json['rattachementMcMcLibelleAr'] ?? '',
      rattachementMcMcLibelleFr: json['rattachementMcMcLibelleFr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apCode': apCode,
      'id': id,
      'idDia': idDia,
      'llPeriode': llPeriode,
      'llPeriodeAr': llPeriodeAr,
      'note': note,
      'observation': observation,
      'rattachementMcMcLibelleAr': rattachementMcMcLibelleAr,
      'rattachementMcMcLibelleFr': rattachementMcMcLibelleFr,
    };
  }
}
