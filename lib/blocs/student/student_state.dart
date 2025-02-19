part of 'student_bloc.dart';

@immutable
sealed class StudentState extends Equatable {
  const StudentState();
}

final class StudentInitial extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentLoadingState extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentLoadedState extends StudentState {
  final Student student;
  const StudentLoadedState({required this.student});
  @override
  List<Object?> get props => [];
}

final class StudentNotFoundState extends StudentState {
  @override
  List<Object?> get props => [];
}

final class FailureState extends StudentState {
  final String errorMessage;
  const FailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class SignInFailureState extends StudentState {
  final String errorMessage;
  const SignInFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
