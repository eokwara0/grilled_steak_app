import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_reservation_repository/table_reservation_repository.dart';

part 'reservation_bottom_sheet_state.dart';

class ReservationBottomSheetCubit extends Cubit<ReservationBottomSheetState> {
  ReservationBottomSheetCubit({required ReservationRepository repo})
      : _reservationRepository = repo,
        super(
          const ReservationBottomSheetInitial(
            status: ReservationBottomSheetStatus.initial,
            table: TableReservation(),
          ),
        );

  final ReservationRepository _reservationRepository;

  addTable(TableReservation table) {
    return emit(
      ReservationBottomSheetLoaded(
          table: table, status: ReservationBottomSheetStatus.loaded),
    );
  }

  removeReservation() async {
    TableReservation table = state._table.copyWith(
      status: 'AVAILABLE',
      reservation: const Reservation(),
    );

    bool response =
        await _reservationRepository.updateReservation(table.id!, table);
    if (response) {
      return emit(
        ReservationBottomSheetSuccess(
            table: state.table, status: ReservationBottomSheetStatus.success),
      );
    }
    return emit(ReservationBottomSheetError(
        table: state.table, status: ReservationBottomSheetStatus.error));
  }
}
