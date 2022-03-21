part of 'bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitialState extends DataState {}

class DataIsLoadingState extends DataState {}

class DataLoadedState extends DataState {}
class DataSavedState extends DataState {}
