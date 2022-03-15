part of 'bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class ImportDataEvent extends DataEvent {}

class LoadDataEvent extends DataEvent {}

class SelectVacancyCategory extends DataEvent {
  final int id;

  const SelectVacancyCategory(this.id);
}

class SelectVacancyTag extends DataEvent {
  final List<int> id;

  const SelectVacancyTag(this.id);

}
