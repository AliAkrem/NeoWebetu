import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/api/period_api.dart';
import 'package:webtu_v2/api/student_api.dart';
import 'package:webtu_v2/blocs/period/period_bloc.dart';
import 'package:webtu_v2/blocs/session/session_bloc.dart';
import 'package:webtu_v2/models/auth_response.dart';
import 'package:webtu_v2/models/student.dart';
import 'package:webtu_v2/services/auth_service.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;
  final PeriodBloc periodBloc;
  final SessionBloc sessionBloc;
  StudentBloc({
    required this.studentRepository,
    required this.periodBloc,
    required this.sessionBloc,
  }) : super(StudentInitial()) {
    on<GetStudentEvent>((event, emit) async {
      emit(StudentLoadingState());
      try {
        final student = await studentRepository.getStudent();

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final AuthResponse? session = await AuthService(prefs).getCurrentUser();

        if (session != null) {
          sessionBloc.add(LoadSessionEvent(session: session));
        }

        emit(StudentLoadedState(student: student));
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });

    on<SignOutStudentEvent>(
      (event, emit) async {
        emit(StudentLoadingState());

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        studentRepository.deleteStudent();
        await prefs.clear();

        emit(StudentNotFoundState());
      },
    );

    on<SignInStudentEvent>(
      (event, emit) async {
        emit(StudentLoadingState());

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        try {
          final session = await AuthService(prefs).login(
            event.username,
            event.password,
          );

          sessionBloc.add(LoadSessionEvent(session: session));

          final student = await getStudentInfo();

          final periods = await getCurrentPeriod(student.levelId);

          emit(StudentLoadedState(student: student));
          studentRepository.addStudent(student);

          periodBloc.add(AddPeriodEvent(periods: periods));
        } catch (e) {
          emit(SignInFailureState(
              errorMessage: "Invalid credentials. Please try again."));
        }
      },
    );
  }
}
