import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';

part 'state.dart';
part 'event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<ImportDataEvent>(_onGetPlaces);
  }

  final DataRepository _repository = getIt<DataRepository>();

  FutureOr<void> _onGetPlaces(
      ImportDataEvent event, Emitter<DataState> emitter) async {
    _repository.importData();
  }
}
