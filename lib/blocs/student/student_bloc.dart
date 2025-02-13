import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/api/student.dart';
import 'package:webtu_v2/models/student.dart';
import 'package:webtu_v2/services/auth_service.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<GetStudentEvent>((event, emit) async {
      emit(StudentLoading());
      try {
        final student = await studentRepository.getStudent();

        if (student.isEmpty()) {
          emit(FailureState(errorMessage: "student not found"));
        } else {
          emit(StudentLoaded(student: student));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });

    on<SignOutStudentEvent>(
      (event, emit) async {
        emit(StudentLoading());

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        AuthService(prefs).logout();
        studentRepository.deleteStudent();

        emit(StudentNotFound());
      },
    );

    on<SignInStudentEvent>(
      (event, emit) async {
        emit(StudentLoading());

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        try {
          await AuthService(prefs).login(
            event.username,
            event.password,
          );

          final student = await getStudentInfo();

          

          studentRepository.addStudent(student);

          emit(StudentLoaded(student: student));
        } catch (e) {
          emit(SignInFailureState(
              errorMessage: "Invalid credentials. Please try again."));
        }
      },
    );
  }
}
