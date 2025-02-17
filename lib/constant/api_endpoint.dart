// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const String BASE_URL = 'https://progres.mesrs.dz';
const String TOKEN_KEY = 'auth_token';
const String SESSION_KEY = 'session_data';
const String AUTH_URL = "$BASE_URL/api/authentication/v1/";
String INDIVIDUAL_URL(String uuid) => "$BASE_URL/api/infos/bac/$uuid/individu";

String STUDENT_IMAGE_URL(String uuid) => "$BASE_URL/api/infos/image/$uuid";

String ITABLISSMENT_LOGO_URL(String establishmentId) =>
    "${BASE_URL}api/infos/logoEtablissement/$establishmentId";
String STUDENT_CARDS_URL(String uuid) => "$BASE_URL/api/infos/bac/$uuid/dias";
String EXAM_NOTES_URL(String cardId) =>
    "${BASE_URL}api/infos/planningSession/dia/$cardId/noteExamens";
String CC_NOTES_URL(String cardId) =>
    "${BASE_URL}api/infos/controleContinue/dia/$cardId/notesCC";

String CHECK_URL(String username) => "$BASE_URL/check/$username";
