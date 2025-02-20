part of 'assessment_notes_bloc.dart';

sealed class AssessmentNotesEvent extends Equatable {
  const AssessmentNotesEvent();

  @override
  List<Object> get props => [];
}

class GetIdleAssessmentNotesEvent extends AssessmentNotesEvent {}

class GetAssessmentNotesEvent extends AssessmentNotesEvent {}

class UpsertAssessmentNotesEvent extends AssessmentNotesEvent {
  final List<AssessmentNote> newNotes;

  const UpsertAssessmentNotesEvent({required this.newNotes});

  @override
  List<Object> get props => [newNotes];
}

class RevalidateAssessmentNotesEvent extends AssessmentNotesEvent {}
