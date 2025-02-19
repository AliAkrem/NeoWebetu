import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/exams_notes.dart';
import 'package:webtu_v2/api/exam_notes_api.dart';
import 'package:webtu_v2/models/exam_notes.dart';

part 'exams_notes_event.dart';
part 'exams_notes_state.dart';

class ExamsNotesBloc extends Bloc<ExamsNotesEvent, ExamsNotesState> {
  final ExamsNotesRepository examRepo;

  ExamsNotesBloc(this.examRepo) : super(ExamsNotesInitial()) {
    on<GetExamNotesEvent>((event, emit) async {
      emit(ExamsNotesLoading());
      final exams = await examRepo.getExamsNotes();
      if (exams != null) {
        emit(ExamsNotesLoaded(notes: exams));
      } else {
        emit(FailureState(errorMessage: 'there are not data to show'));
      }
    });

    on<UpsertExamsNotesEvent>((event, emit) async {
      emit(ExamsNotesLoading());

      await examRepo.upsertExamsNotes(event.newNotes);

      //? revalidate data :P
      add(GetExamNotesEvent());
    });

    on<RevalidateExamNotesEvent>(
      (event, emit) async {
        final notes = await getExamNotes();

        if (notes != null) {
          add(UpsertExamsNotesEvent(newNotes: notes));
        }
      },
    );
  }
}
