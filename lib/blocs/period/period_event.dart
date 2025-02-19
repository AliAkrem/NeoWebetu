part of 'period_bloc.dart';

sealed class PeriodEvent extends Equatable {
  const PeriodEvent();

  @override
  List<Object> get props => [];
}


class GetPeriod extends PeriodEvent {
  const GetPeriod();
}



class AddPeriod extends PeriodEvent {
  final List<Period> periods;
  const AddPeriod({required this.periods});

  @override
  List<Object> get props => [periods];
}


class UpdatePeriod extends PeriodEvent {
  final Period period;
  const UpdatePeriod(this.period);

  @override
  List<Object> get props => [period];
}
