part of 'manage_table_cubit.dart';

abstract class ManageTableState extends Equatable {
  const ManageTableState([
    List<TableReservation> availableTables = const [],
    List<TableReservation> reservedTables = const [],
  ])  : _availableTables = availableTables,
        _reservedTables = reservedTables;

  // properties
  final List<TableReservation> _availableTables;
  final List<TableReservation> _reservedTables;

  // checks
  bool get isLoaded => this is ManageTableLoaded;
  bool get isError => this is ManageTableError;
  bool get isInitial => this is ManageTableInitial;

  // Getters
  List<TableReservation> get availableTables => _availableTables;
  List<TableReservation> get reservedTables => _reservedTables;

  @override
  List<Object> get props => [
        _availableTables,
        _reservedTables,
      ];
}

class ManageTableInitial extends ManageTableState {}

class ManageTableLoaded extends ManageTableState {
  const ManageTableLoaded({
    required List<TableReservation> aTables,
    required List<TableReservation> rTable,
  }) : super(aTables, rTable);
}

class ManageTableError extends ManageTableState {}
