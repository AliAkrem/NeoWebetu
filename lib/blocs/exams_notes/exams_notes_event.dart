part of 'exams_notes_bloc.dart';

sealed class ExamsNotesEvent extends Equatable {
  const ExamsNotesEvent();

  @override
  List<Object> get props => [];
}

class GetExamNotesEvent extends ExamsNotesEvent {}

class UpsertExamsNotesEvent extends ExamsNotesEvent {
  final List<ExamNotes> newNotes;

  const UpsertExamsNotesEvent({required this.newNotes});

  @override
  List<Object> get props => [newNotes];
}

class RevalidateExamNotesEvent extends ExamsNotesEvent {}
