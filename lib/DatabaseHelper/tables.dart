class Tables {
  static String StudentTableName = "students";

  static String StudentTable = '''
   CREATE TABLE IF NOT EXISTS $StudentTableName(
    id INTEGER,
    anneeAcademiqueCode TEXT,
    anneeAcademiqueId INTEGER,
    individuDateNaissance TEXT,
    individuLieuNaissance TEXT,
    individuLieuNaissanceArabe TEXT,
    individuNomArabe TEXT,
    individuNomLatin TEXT,
    individuPrenomArabe TEXT,
    individuPrenomLatin TEXT,
    llEtablissementArabe TEXT,
    llEtablissementLatin TEXT,
    niveauId INTEGER,
    niveauLibelleLongAr TEXT,
    niveauLibelleLongLt TEXT,
    numeroInscription TEXT,
    ofLlDomaine TEXT,
    ofLlDomaineArabe TEXT,
    ofLlFiliere TEXT,
    ofLlFiliereArabe TEXT,
    ofLlSpecialite TEXT,
    ofLlSpecialiteArabe TEXT,
    ouvertureOffreFormationId INTEGER,
    refLibelleCycle TEXT,
    refLibelleCycleAr TEXT,
    situationId INTEGER,
    uuid TEXT,
    image TEXT
   )''';
}
