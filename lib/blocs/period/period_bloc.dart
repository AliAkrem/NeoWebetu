import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/periods.dart';
import 'package:webtu_v2/models/period.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodRepository periodRepository;

  PeriodBloc({required this.periodRepository}) : super(PeriodInitial()) {
    on<GetPeriod>((event, emit) async {
      emit(PeriodLoading());
      try {
        final List<Period> periods = await periodRepository.getPeriod();
        emit(PeriodLoaded(periods));
      } catch (e) {
        emit(PeriodError(e.toString()));
      }
    });

    on<AddPeriod>((event, emit) async {
      emit(PeriodLoading());
      try {
        final int count = await periodRepository.addPeriods(event.periods);
        if (count > 0) {
          final List<Period> periods = await periodRepository.getPeriod();
          emit(PeriodLoaded(periods));
        } else {
          emit(PeriodError("Failed to add periods"));
        }
      } catch (e) {
        emit(PeriodError(e.toString()));
      }
    });

    on<UpdatePeriod>((event, emit) async {
      emit(PeriodLoading());
      try {
        final int count = await periodRepository.updatePeriod(event.period);
        if (count > 0) {
          final List<Period> periods = await periodRepository.getPeriod();
          emit(PeriodLoaded(periods));
        } else {
          emit(PeriodError("Failed to update period"));
        }
      } catch (e) {
        emit(PeriodError(e.toString()));
      }
    });

    //   on<DeletePeriod>((event, emit) async {
    //     emit(PeriodLoading());
    //     try {
    //       final int count = await periodRepository.deletePeriod();
    //       if (count > 0) {
    //         emit(PeriodInitial());
    //       } else {
    //         emit(PeriodError("Failed to delete period"));
    //       }
    //     } catch (e) {
    //       emit(PeriodError(e.toString()));
    //     }
    //   });
  }
}
