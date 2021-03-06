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

class SaveVacancyEvent extends DataEvent {
  final VacancyData data;
  final String token;

  const SaveVacancyEvent(this.data, this.token);
}


class SavePostEvent extends DataEvent {
  final PostData data;
  final String token;

  const SavePostEvent(this.data, this.token);
}


class SaveCommentEvent extends DataEvent {
  final CommentData data;
  final String token;

  const SaveCommentEvent(this.data, this.token);
}

class SaveVacancyRequestEvent extends DataEvent {
  final VacancyRequestData data;
  final String token;

  const SaveVacancyRequestEvent(this.data, this.token);
}
