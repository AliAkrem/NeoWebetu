part of 'session_bloc.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

final class LoadSessionEvent extends SessionEvent {
  final AuthResponse session;
  const LoadSessionEvent({required this.session});
}
