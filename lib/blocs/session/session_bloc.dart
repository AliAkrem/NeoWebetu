import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtu_v2/models/auth_response.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitial()) {
    on<LoadSessionEvent>((event, emit) {
      emit(SessionLoadedState(session: event.session));
    });
  }
}
