import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_reservation_repository/table_reservation_repository.dart';

part 'manage_table_state.dart';

class ManageTableCubit extends Cubit<ManageTableState> {
  ManageTableCubit({
    required ReservationRepository reservationRepository,
  })  : _reservationRepository = reservationRepository,
        super(ManageTableInitial()) {
    initialize();
  }

  // properties
  final ReservationRepository _reservationRepository;
  initialize() async {
    List<TableReservation>? aTables =
        await _reservationRepository.getAvailableTables();
    List<TableReservation>? rTables =
        await _reservationRepository.getReservedTables();

    if (aTables != null && rTables != null) {
      return emit(ManageTableLoaded(
        aTables: aTables,
        rTable: rTables,
      ));
    }
    return emit(
      ManageTableError(),
    );
  }
}
