part of 'session_bloc.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class SessionInitial extends SessionState {}

final class SessionLoadingState extends SessionState {}

class SessionLoadedState extends SessionState {
  final AuthResponse session;
  const SessionLoadedState({required this.session});
}

class SessionFailure extends SessionState {
  final String errorMessage;

  const SessionFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
