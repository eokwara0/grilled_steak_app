part of 'table_edit_cubit.dart';

abstract class TableEditState extends Equatable {
  const TableEditState({
    required TableReservation table,
    required Reservation reservation,
    required FormzStatus status,
    Email? email,
    Username? firstname,
    Username? lastname,
    PhoneNumber? number,
  })  : _table = table,
        _reservation = reservation,
        _email = email,
        _firstname = firstname,
        _lastname = lastname,
        _number = number,
        _status = status;

  final FormzStatus _status;
  final Reservation _reservation;
  final TableReservation _table;
  final Email? _email;
  final Username? _firstname;
  final Username? _lastname;
  final PhoneNumber? _number;

  //Getters
  TableReservation get table => _table;
  Reservation get reservation => _reservation;
  Email? get email => _email;
  Username? get firstname => _firstname;
  Username? get lastname => _lastname;
  PhoneNumber? get number => _number;
  FormzStatus get status => _status;

  // checks
  bool get isSbumitted => this is TableEditSubmit;
  bool get isError => this is TableEditError;
  bool get isChanged => this is TableEditChanged;
  bool get isInitial => this is TableEditInitial;
  @override
  List<Object?> get props => [
        _table,
        _reservation,
        _email,
        _firstname,
        _lastname,
        _number,
        _table.capacity,
        _status,
      ];
}

class TableEditInitial extends TableEditState {
  const TableEditInitial({
    required super.table,
    required super.reservation,
    super.email,
    super.firstname,
    super.lastname,
    super.number,
    required super.status,
  });
}

class TableEditChanged extends TableEditState {
  const TableEditChanged({
    required super.table,
    required super.reservation,
    super.email,
    super.firstname,
    super.lastname,
    super.number,
    required super.status,
  });
}

class TableEditSubmit extends TableEditState {
  const TableEditSubmit({
    required super.table,
    required super.reservation,
    super.email,
    super.firstname,
    super.lastname,
    super.number,
    required super.status,
  });
}

class TableEditError extends TableEditState {
  const TableEditError({
    required super.table,
    required super.reservation,
    super.email,
    super.firstname,
    super.lastname,
    super.number,
    required super.status,
  });
}
