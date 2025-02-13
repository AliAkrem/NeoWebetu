class Student {
  final DateTime? dateOfBirth;
  final int? id;
  final String? placeOfBirth;
  final String? placeOfBirthArabic;
  final String? lastNameArabic;
  final String? lastNameLatin;
  final String? socialSecurityNumber;
  final String? firstNameArabic;
  final String? firstNameLatin;

  Student({
    this.dateOfBirth,
    this.id,
    this.placeOfBirth,
    this.placeOfBirthArabic,
    this.lastNameArabic,
    this.lastNameLatin,
    this.socialSecurityNumber,
    this.firstNameArabic,
    this.firstNameLatin,
  });

  Student copyWith({
    DateTime? dateOfBirth,
    int? id,
    String? placeOfBirth,
    String? placeOfBirthArabic,
    String? lastNameArabic,
    String? lastNameLatin,
    String? socialSecurityNumber,
    String? firstNameArabic,
    String? firstNameLatin,
  }) =>
      Student(
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        id: id ?? this.id,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        placeOfBirthArabic: placeOfBirthArabic ?? this.placeOfBirthArabic,
        lastNameArabic: lastNameArabic ?? this.lastNameArabic,
        lastNameLatin: lastNameLatin ?? this.lastNameLatin,
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        firstNameArabic: firstNameArabic ?? this.firstNameArabic,
        firstNameLatin: firstNameLatin ?? this.firstNameLatin,
      );

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      dateOfBirth: DateTime.parse(json['dateNaissance']),
      id: json['id'],
      placeOfBirth: json['lieuNaissance'],
      placeOfBirthArabic: json['lieuNaissanceArabe'],
      lastNameArabic: json['nomArabe'],
      lastNameLatin: json['nomLatin'],
      socialSecurityNumber: json['nss'],
      firstNameArabic: json['prenomArabe'],
      firstNameLatin: json['prenomLatin'],
    );
  }

  bool isEmpty() {
    return dateOfBirth == null &&
        id == null &&
        placeOfBirth == null &&
        placeOfBirthArabic == null &&
        lastNameArabic == null &&
        lastNameLatin == null &&
        socialSecurityNumber == null &&
        firstNameArabic == null &&
        firstNameLatin == null;
  }

  Map<String, dynamic> toJson() {
    return {
      'dateNaissance': dateOfBirth?.toIso8601String(),
      'id': id,
      'lieuNaissance': placeOfBirth,
      'lieuNaissanceArabe': placeOfBirthArabic,
      'nomArabe': lastNameArabic,
      'nomLatin': lastNameLatin,
      'nss': socialSecurityNumber,
      'prenomArabe': firstNameArabic,
      'prenomLatin': firstNameLatin,
    };
  }
}
