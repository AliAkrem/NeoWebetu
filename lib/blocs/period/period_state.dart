part of 'period_bloc.dart';

sealed class PeriodState extends Equatable {
  const PeriodState();

  @override
  List<Object> get props => [];
}

final class PeriodInitial extends PeriodState {}

final class PeriodLoading extends PeriodState {}

final class PeriodLoaded extends PeriodState {
  final List<Period> periods;
  const PeriodLoaded(this.periods);

  @override
  List<Object> get props => [periods];
}

final class PeriodError extends PeriodState {
  final String message;
  const PeriodError(this.message);

  @override
  List<Object> get props => [message];
}
