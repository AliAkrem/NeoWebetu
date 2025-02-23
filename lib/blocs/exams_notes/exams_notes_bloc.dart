import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neowebetu/DatabaseHelper/Repositories/exams_notes.dart';
import 'package:neowebetu/api/exam_notes_api.dart';
import 'package:neowebetu/models/exam_notes.dart';

part 'exams_notes_event.dart';
part 'exams_notes_state.dart';

class ExamsNotesBloc extends Bloc<ExamsNotesEvent, ExamsNotesState> {
  final ExamsNotesRepository examRepo;

  ExamsNotesBloc(this.examRepo) : super(ExamsNotesInitial()) {
    on<GetStaleExamNotesEvent>((event, emit) async {
      emit(ExamsNotesLoading());
      final exams = await examRepo.getExamsNotes();
      if (exams != null) {
        emit(ExamsNotesLoaded(notes: exams));
      } else {
        emit(const FailureState(errorMessage: 'there are not data to show'));
      }
    });

    on<UpsertExamsNotesEvent>((event, emit) async {
      emit(ExamsNotesLoading());

      await examRepo.upsertExamsNotes(event.newNotes);

      //? revalidate data :P
      add(GetStaleExamNotesEvent());
    });

    on<GetExamNotesEvent>((event, emit) async {
      // TODO (DEV) : this event will decide wthere to get revalidate data or get stale data

      add(RevalidateExamNotesEvent());
    });

    on<RevalidateExamNotesEvent>(
      (event, emit) async {
        final res = await getExamNotes();

        add(UpsertExamsNotesEvent(newNotes: res.notes));
      },
    );
  }
}
