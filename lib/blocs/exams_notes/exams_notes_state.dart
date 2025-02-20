part of 'exams_notes_bloc.dart';

sealed class ExamsNotesState extends Equatable {
  const ExamsNotesState();

  @override
  List<Object> get props => [];
}

final class ExamsNotesInitial extends ExamsNotesState {}

final class ExamsNotesLoading extends ExamsNotesState {}
   
final class ExamsNotesLoaded extends ExamsNotesState {
  final List<ExamNotes> notes;

  const ExamsNotesLoaded({required this.notes});
  @override
  List<Object> get props => [];
}

final class FailureState extends ExamsNotesState {
  final String errorMessage;

  const FailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
