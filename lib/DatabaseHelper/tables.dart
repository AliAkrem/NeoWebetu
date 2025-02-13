 class Tables {
  static String StudentTableName = "students";

  static String StudentTable = '''
   CREATE TABLE IF NOT EXISTS $StudentTableName(
   id INTEGER PRIMARY KEY,
   dateNaissance TEXT,
   lieuNaissance TEXT,
   lieuNaissanceArabe TEXT,
   nomArabe TEXT,
   nomLatin TEXT,
   nss TEXT,
   prenomArabe TEXT,
   prenomLatin TEXT
   )''';
 }