part of 'period_bloc.dart';

sealed class PeriodState extends Equatable {
  const PeriodState();

  @override
  List<Object> get props => [];
}

final class PeriodInitial extends PeriodState {}

final class PeriodLoadingState extends PeriodState {}

final class PeriodLoadedState extends PeriodState {
  final List<Period> periods;
  const PeriodLoadedState(this.periods);

  @override
  List<Object> get props => [periods];
}

final class PeriodFailureState extends PeriodState {
  final String message;
  const PeriodFailureState(this.message);

  @override
  List<Object> get props => [message];
}
