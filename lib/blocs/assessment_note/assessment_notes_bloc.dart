import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neowebetu/DatabaseHelper/Repositories/assessment_notes.dart';
import 'package:neowebetu/api/assessment_notes_api.dart';
import 'package:neowebetu/models/assessment_notes.dart';

part 'assessment_notes_event.dart';
part 'assessment_notes_state.dart';

class AssessmentNotesBloc
    extends Bloc<AssessmentNotesEvent, AssessmentNotesState> {
  final _db = AssessmentNotesRepository();

  AssessmentNotesBloc() : super(AssessmentNotesInitial()) {
    on<GetIdleAssessmentNotesEvent>((event, emit) async {
      emit(AssessmentNoteLoading());
      final notes = await _db.getAssessmentNotes();
      if (notes.isNotEmpty) {
        emit(AssessmentNotesLoaded(notes: notes));
      } else {
        emit(const FailureState(errorMessage: 'there are not data to show'));
      }
    });

    on<UpsertAssessmentNotesEvent>((event, emit) async {
      emit(AssessmentNoteLoading());

      await _db.upsertAssessmentNotes(event.newNotes);

      //? revalidate data :P
      add(GetIdleAssessmentNotesEvent());
    });

    on<GetAssessmentNotesEvent>(
      (event, emit) {
        // TODO (DEV) : this event will decide wthere to get revalidate data or get stale data

        add(RevalidateAssessmentNotesEvent());
      },
    );

    on<RevalidateAssessmentNotesEvent>(
      (event, emit) async {
        final res = await getAssessments();

        add(UpsertAssessmentNotesEvent(newNotes: res.notes));
      },
    );
  }
}
