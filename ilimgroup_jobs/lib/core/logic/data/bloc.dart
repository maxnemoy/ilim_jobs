import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';

part 'state.dart';
part 'event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitialState()) {
    on<ImportDataEvent>(_onGetPlaces);
    on<LoadDataEvent>(_onLoadData);
    on<SelectVacancyCategory>(_onCategorySelect);
    on<SelectVacancyTag>(_onTagSelect);
    on<SaveVacancyEvent>(_onSaveVacancy);
    on<SavePostEvent>(_onSavePost);
  }

  final DataRepository _repository = getIt<DataRepository>();

  FutureOr<void> _onGetPlaces(
      ImportDataEvent event, Emitter<DataState> emitter) async {
    _repository.importData();
  }

  FutureOr<void> _onLoadData(
      LoadDataEvent event, Emitter<DataState> emitter) async {
    emitter(DataIsLoadingState());
    await _repository.loadData();
    emitter(DataLoadedState());
  }

  FutureOr<void> _onCategorySelect(
      SelectVacancyCategory event, Emitter<DataState> emitter) async {
    emitter(DataIsLoadingState());
    _repository.selectCategory(event.id);
    await _repository.sortByCategory(_repository.selectedCategory);
    emitter(DataLoadedState());
  }

  FutureOr<void> _onTagSelect(
      SelectVacancyTag event, Emitter<DataState> emitter) async {
    emitter(DataIsLoadingState());
    _repository.selectTag(event.id);
    await _repository.sortByCategory(_repository.selectedCategory);
    emitter(DataLoadedState());
  }

  FutureOr<void> _onSaveVacancy(
      SaveVacancyEvent event, Emitter<DataState> emitter) async {
    emitter(DataIsLoadingState());
    if (event.data.id != null) {
      await _repository.upgradeVacancy(event.data, event.token);
    } else {
      await _repository.createVacancy(event.data, event.token);
    }
    await _repository.loadData();
    emitter(DataSavedState());
    emitter(DataLoadedState());
  }

  FutureOr<void> _onSavePost(
      SavePostEvent event, Emitter<DataState> emitter) async {
    emitter(DataIsLoadingState());
    if (event.data.id != null) {
      await _repository.upgradePost(event.data, event.token);
    } else {
      await _repository.createPost(event.data, event.token);
    }
    await _repository.loadData();
    emitter(DataSavedState());
    emitter(DataLoadedState());
  }
}
