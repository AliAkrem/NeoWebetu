class Period {
  final String code;
  final int id;
  final String longLabelAr;
  final String longLabelArCycle;
  final String longLabelArLevel;
  final String longLabelFrCycle;
  final String longLabelFrLevel;
  final String longLabel;
  final int rank;

  Period({
    required this.code,
    required this.id,
    required this.longLabelAr,
    required this.longLabelArCycle,
    required this.longLabelArLevel,
    required this.longLabelFrCycle,
    required this.longLabelFrLevel,
    required this.longLabel,
    required this.rank,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      code: json['code'],
      id: json['id'],
      longLabelAr: json['libelleLongAr'],
      longLabelArCycle: json['libelleLongArCycle'],
      longLabelArLevel: json['libelleLongArNiveau'],
      longLabelFrCycle: json['libelleLongFrCycle'],
      longLabelFrLevel: json['libelleLongFrNiveau'],
      longLabel: json['libelleLongLt'],
      rank: json['rang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'id': id,
      'libelleLongAr': longLabelAr,
      'libelleLongArCycle': longLabelArCycle,
      'libelleLongArNiveau': longLabelArLevel,
      'libelleLongFrCycle': longLabelFrCycle,
      'libelleLongFrNiveau': longLabelFrLevel,
      'libelleLongLt': longLabel,
      'rang': rank,
    };
  }
}
