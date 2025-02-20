part of 'assessment_notes_bloc.dart';

sealed class AssessmentNotesState extends Equatable {
  const AssessmentNotesState();

  @override
  List<Object> get props => [];
}

final class AssessmentNotesInitial extends AssessmentNotesState {}

final class AssessmentNoteLoading extends AssessmentNotesState {}

final class AssessmentNotesLoaded extends AssessmentNotesState {
  final List<AssessmentNote> notes;

  const AssessmentNotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

final class FailureState extends AssessmentNotesState {
  final String errorMessage;

  const FailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
