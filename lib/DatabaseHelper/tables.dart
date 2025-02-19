// ignore_for_file: non_constant_identifier_names

class Tables {
  static String StudentTableName = "students";
  static String ExamTableName = "exams_notes";
  static String PeriodTableName = "period";

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
   );''';

  static String ExamNoteTable = '''
  CREATE TABLE IF NOT EXISTS $ExamTableName(
    id int PRIMARY KEY NOT NULL ,
    id_dia INTEGER ,
    mcLibelleAr TEXT,
    mcLibelleFr TEXT,
    noteExamen REAL,
    idPeriode INTEGER,
    rattachementMcCoefficient INTEGER
  );''';

  static String PeriodTable = '''
  CREATE TABLE IF NOT EXISTS $PeriodTableName(
    id INTEGER PRIMARY KEY NOT NULL,
    code TEXT,
    libelleLongAr TEXT,
    libelleLongArCycle TEXT,
    libelleLongArNiveau TEXT,
    libelleLongFrCycle TEXT,
    libelleLongFrNiveau TEXT,
    libelleLongLt TEXT,
    rang INTEGER
  );''';
}
