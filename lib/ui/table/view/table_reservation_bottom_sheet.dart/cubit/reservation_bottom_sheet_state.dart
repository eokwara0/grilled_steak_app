part of 'reservation_bottom_sheet_cubit.dart';

enum ReservationBottomSheetStatus { initial, error, success, loaded }

abstract class ReservationBottomSheetState extends Equatable {
  const ReservationBottomSheetState({
    required TableReservation table,
    required ReservationBottomSheetStatus status,
  })  : _table = table,
        _status = status;

  final TableReservation _table;
  final ReservationBottomSheetStatus _status;

  // Getters
  TableReservation get table => _table;
  ReservationBottomSheetStatus get status => _status;

  // checks
  bool get isLoaded => this is ReservationBottomSheetLoaded;
  bool get isSuccess => this is ReservationBottomSheetSuccess;
  bool get isError => this is ReservationBottomSheetError;
  bool get isInitial => this is ReservationBottomSheetInitial;

  @override
  List<Object> get props => [_table, _status];
}

class ReservationBottomSheetInitial extends ReservationBottomSheetState {
  const ReservationBottomSheetInitial({
    required super.table,
    required super.status,
  });
}

class ReservationBottomSheetLoaded extends ReservationBottomSheetState {
  const ReservationBottomSheetLoaded({
    required super.table,
    required super.status,
  });
}

class ReservationBottomSheetError extends ReservationBottomSheetState {
  const ReservationBottomSheetError({
    required super.table,
    required super.status,
  });
}

class ReservationBottomSheetSuccess extends ReservationBottomSheetState {
  const ReservationBottomSheetSuccess({
    required super.table,
    required super.status,
  });
}
