class Student {
  final String academicYearCode;
  final int academicYearId;
  final int id;
  final DateTime birthDate;
  final String birthPlace;
  final String birthPlaceArabic;
  final String lastNameArabic;
  final String lastNameLatin;
  final String firstNameArabic;
  final String firstNameLatin;
  final String institutionNameArabic;
  final String institutionNameLatin;
  final int levelId;
  final String levelLongLabelArabic;
  final String levelLongLabelLatin;
  final String registrationNumber;
  final String domainLabel;
  final String domainLabelArabic;
  final String branchLabel;
  final String branchLabelArabic;
  final String? specialtyLabel;
  final String? specialtyLabelArabic;
  final int trainingOfferOpeningId;
  final String refCycleLabel;
  final String refCycleLabelArabic;
  final int statusId;
  final String uuid;
  final String imageBase64;

  Student(
      {required this.academicYearCode,
      required this.academicYearId,
      required this.id,
      required this.birthDate,
      required this.birthPlace,
      required this.birthPlaceArabic,
      required this.lastNameArabic,
      required this.lastNameLatin,
      required this.firstNameArabic,
      required this.firstNameLatin,
      required this.institutionNameArabic,
      required this.institutionNameLatin,
      required this.levelId,
      required this.levelLongLabelArabic,
      required this.levelLongLabelLatin,
      required this.registrationNumber,
      required this.domainLabel,
      required this.domainLabelArabic,
      required this.branchLabel,
      required this.branchLabelArabic,
       this.specialtyLabel,
       this.specialtyLabelArabic,
      required this.trainingOfferOpeningId,
      required this.refCycleLabel,
      required this.refCycleLabelArabic,
      required this.statusId,
      required this.uuid,
      required this.imageBase64});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      academicYearCode: json['anneeAcademiqueCode'] as String,
      academicYearId: json['anneeAcademiqueId'] as int,
      id: json['id'] as int,
      birthDate: DateTime.parse(json['individuDateNaissance'] as String),
      birthPlace: json['individuLieuNaissance'] as String,
      birthPlaceArabic: json['individuLieuNaissanceArabe'] as String,
      lastNameArabic: json['individuNomArabe'] as String,
      lastNameLatin: json['individuNomLatin'] as String,
      firstNameArabic: json['individuPrenomArabe'] as String,
      firstNameLatin: json['individuPrenomLatin'] as String,
      institutionNameArabic: json['llEtablissementArabe'] as String,
      institutionNameLatin: json['llEtablissementLatin'] as String,
      levelId: json['niveauId'] as int,
      levelLongLabelArabic: json['niveauLibelleLongAr'] as String,
      levelLongLabelLatin: json['niveauLibelleLongLt'] as String,
      registrationNumber: json['numeroInscription'] as String,
      domainLabel: json['ofLlDomaine'] as String,
      domainLabelArabic: json['ofLlDomaineArabe'] as String,
      branchLabel: json['ofLlFiliere'] as String,
      branchLabelArabic: json['ofLlFiliereArabe'] as String,
      specialtyLabel: json['ofLlSpecialite'] ?? "" as String?,
      specialtyLabelArabic: json['ofLlSpecialiteArabe'] ?? "" as String?,
      trainingOfferOpeningId: json['ouvertureOffreFormationId'] as int,
      refCycleLabel: json['refLibelleCycle'] as String,
      refCycleLabelArabic: json['refLibelleCycleAr'] as String,
      statusId: json['situationId'] as int,
      uuid: json['uuid'] as String,
      imageBase64: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anneeAcademiqueCode': academicYearCode,
      'anneeAcademiqueId': academicYearId,
      'id': id,
      'individuDateNaissance': birthDate.toIso8601String(),
      'individuLieuNaissance': birthPlace,
      'individuLieuNaissanceArabe': birthPlaceArabic,
      'individuNomArabe': lastNameArabic,
      'individuNomLatin': lastNameLatin,
      'individuPrenomArabe': firstNameArabic,
      'individuPrenomLatin': firstNameLatin,
      'llEtablissementArabe': institutionNameArabic,
      'llEtablissementLatin': institutionNameLatin,
      'niveauId': levelId,
      'niveauLibelleLongAr': levelLongLabelArabic,
      'niveauLibelleLongLt': levelLongLabelLatin,
      'numeroInscription': registrationNumber,
      'ofLlDomaine': domainLabel,
      'ofLlDomaineArabe': domainLabelArabic,
      'ofLlFiliere': branchLabel,
      'ofLlFiliereArabe': branchLabelArabic,
      'ofLlSpecialite': specialtyLabel,
      'ofLlSpecialiteArabe': specialtyLabelArabic,
      'ouvertureOffreFormationId': trainingOfferOpeningId,
      'refLibelleCycle': refCycleLabel,
      'refLibelleCycleAr': refCycleLabelArabic,
      'situationId': statusId,
      'uuid': uuid,
      'image': imageBase64
    };
  }
}


//         "anneeAcademiqueCode": "2024/2025",
//         "anneeAcademiqueId": 22,
//         "id": 13243010,
//         "individuDateNaissance": "2001-12-29",
//         "individuLieuNaissance": "MOHAMADIA",
//         "individuLieuNaissanceArabe": "المحمدية",
//         "individuNomArabe": "بركة",
//         "individuNomLatin": "BARKA",
//         "individuPrenomArabe": "علي أكرم",
//         "individuPrenomLatin": "ALI AKREM",
//         "llEtablissementArabe": "جامعة معسكر",
//         "llEtablissementLatin": "université de mascara",
//         "niveauId": 13,
//         "niveauLibelleLongAr": "الماستر",
//         "niveauLibelleLongLt": "Master 2",
//         "numeroInscription": "UN29012024202038045295",
//         "ofLlDomaine": "Mathématiques et Informatique",
//         "ofLlDomaineArabe": "رياضيات و إعلام آلي",
//         "ofLlFiliere": "Informatique",
//         "ofLlFiliereArabe": "إعلام آلي",
//         "ofLlSpecialite": "Réseaux et systèmes distribués",
//         "ofLlSpecialiteArabe": " شبكات والأنظمة الموزعة",
//         "ouvertureOffreFormationId": 79464,
//         "refLibelleCycle": "master",
//         "refLibelleCycleAr": "الماستر",
//         "situationId": 26,
//         "uuid": "0f5b98ee-2428-4d42-aafd-71533b450262"