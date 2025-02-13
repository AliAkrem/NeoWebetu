part of 'student_bloc.dart';

@immutable
sealed class StudentEvent extends Equatable {
  const StudentEvent();
}

class GetStudentEvent extends StudentEvent {
  @override
  List<Object> get props => [];
}

class SignInStudentEvent extends StudentEvent {
  final String username;
  final String password;

  const SignInStudentEvent(this.username, this.password);

  @override
  List<Object> get props => [];
}

class SignOutStudentEvent extends StudentEvent {
  @override
  List<Object> get props => [];
}
