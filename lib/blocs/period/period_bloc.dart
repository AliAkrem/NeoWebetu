import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/periods.dart';
import 'package:webtu_v2/models/period.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodRepository periodRepository;

  PeriodBloc({required this.periodRepository}) : super(PeriodInitial()) {
    on<GetPeriodEvent>((event, emit) async {
      emit(PeriodLoadingState());
      try {
        final List<Period> periods = await periodRepository.getPeriod();
        emit(PeriodLoadedState(periods));
      } catch (e) {
        emit(PeriodFailureState(e.toString()));
      }
    });

    on<AddPeriodEvent>((event, emit) async {
      emit(PeriodLoadingState());
      try {
        final int count = await periodRepository.addPeriods(event.periods);
        if (count > 0) {
          final List<Period> periods = await periodRepository.getPeriod();
          emit(PeriodLoadedState(periods));
        } else {
          emit(PeriodFailureState("Failed to add periods"));
        }
      } catch (e) {
        emit(PeriodFailureState(e.toString()));
      }
    });

    on<UpdatePeriodEvent>((event, emit) async {
      emit(PeriodLoadingState());
      try {
        final int count = await periodRepository.updatePeriod(event.period);
        if (count > 0) {
          final List<Period> periods = await periodRepository.getPeriod();
          emit(PeriodLoadedState(periods));
        } else {
          emit(PeriodFailureState("Failed to update period"));
        }
      } catch (e) {
        emit(PeriodFailureState(e.toString()));
      }
    });
  }
}
