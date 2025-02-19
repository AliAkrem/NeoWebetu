part of 'period_bloc.dart';

sealed class PeriodEvent extends Equatable {
  const PeriodEvent();

  @override
  List<Object> get props => [];
}


class GetPeriodEvent extends PeriodEvent {
  const GetPeriodEvent();
}



class AddPeriodEvent extends PeriodEvent {
  final List<Period> periods;
  const AddPeriodEvent({required this.periods});

  @override
  List<Object> get props => [periods];
}


class UpdatePeriodEvent extends PeriodEvent {
  final Period period;
  const UpdatePeriodEvent(this.period);

  @override
  List<Object> get props => [period];
}
