class Student {
  final DateTime dateOfBirth;
  final int id;
  final String placeOfBirth;
  final String placeOfBirthArabic;
  final String lastNameArabic;
  final String lastNameLatin;
  final String socialSecurityNumber;
  final String firstNameArabic;
  final String firstNameLatin;
  final String imageBase64;

  Student({
    required this.imageBase64,
    required this.dateOfBirth,
    required this.id,
    required this.placeOfBirth,
    required this.placeOfBirthArabic,
    required this.lastNameArabic,
    required this.lastNameLatin,
    required this.socialSecurityNumber,
    required this.firstNameArabic,
    required this.firstNameLatin,
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
    String? imageBase64,
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
        imageBase64: firstNameLatin ?? this.firstNameLatin,
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
        imageBase64: json['image']);
  }


  Map<String, dynamic> toJson() {
    return {
      'dateNaissance': dateOfBirth.toIso8601String(),
      'id': id,
      'lieuNaissance': placeOfBirth,
      'lieuNaissanceArabe': placeOfBirthArabic,
      'nomArabe': lastNameArabic,
      'nomLatin': lastNameLatin,
      'nss': socialSecurityNumber,
      'prenomArabe': firstNameArabic,
      'prenomLatin': firstNameLatin,
      'image': imageBase64
    };
  }
}
