import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neowebetu/DatabaseHelper/Repositories/periods.dart';
import 'package:neowebetu/models/period.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodRepository periodRepository = PeriodRepository();

  PeriodBloc() : super(PeriodInitial()) {
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
          emit(const PeriodFailureState("Failed to add periods"));
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
          emit(const PeriodFailureState("Failed to update period"));
        }
      } catch (e) {
        emit(PeriodFailureState(e.toString()));
      }
    });
  }
}
