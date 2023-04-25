part of 'search_bottom_sheet_cubit.dart';

enum SearchBottomSheetStatus { error, success, initial }

abstract class SearchBottomSheetState extends Equatable {
  final List<MenuItem> _result;
  final SearchBottomSheetStatus _status;
  const SearchBottomSheetState({
    required List<MenuItem> result,
    required SearchBottomSheetStatus status,
  })  : _result = result,
        _status = status;

  List<MenuItem> get result => _result;
  SearchBottomSheetStatus get status => _status;

  bool get isLoaded => this is SearchBottomSheetLoaded;
  bool get isError => this is SearchBottomSheetError;
  bool get isInitial => this is SearchBottomSheetInitial;
  //
  @override
  List<Object> get props => [
        _result,
        _status,
      ];
}

class SearchBottomSheetInitial extends SearchBottomSheetState {
  const SearchBottomSheetInitial({
    required super.result,
    required super.status,
  });
}

class SearchBottomSheetLoaded extends SearchBottomSheetState {
  const SearchBottomSheetLoaded({
    required super.result,
    required super.status,
  });
}

class SearchBottomSheetError extends SearchBottomSheetState {
  const SearchBottomSheetError({
    required super.result,
    required super.status,
  });
}
