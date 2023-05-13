import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grilled_steak_app/ui/login/models/username.dart';
import 'package:table_reservation_repository/table_reservation_repository.dart';

import '../../../../login/models/email.dart';
import '../../../../login/models/number.dart';

part 'table_edit_state.dart';

class TableEditCubit extends Cubit<TableEditState> {
  TableEditCubit({
    required ReservationRepository reservationRepository,
  })  : _reservationRepository = reservationRepository,
        super(
          const TableEditInitial(
            table: TableReservation(),
            reservation: Reservation(),
            email: Email.dirty(),
            firstname: Username.dirty(),
            lastname: Username.dirty(),
            number: PhoneNumber.dirty(),
          ),
        );

  final ReservationRepository _reservationRepository;

  addTable(TableReservation table) {
    return emit(
      TableEditChanged(
        table: table,
        reservation: const Reservation(),
        email: const Email.dirty(),
        firstname: const Username.dirty(),
        lastname: const Username.dirty(),
        number: const PhoneNumber.dirty(),
      ),
    );
  }

  dateChanged(DateTime start, DateTime end) {
    return emit(
      TableEditChanged(
        table: state._table,
        reservation: state._reservation.copyWith(
          startDate: start,
          endDate: end,
        ),
        firstname: state._firstname,
        email: state._email,
        lastname: state._lastname,
        number: state._number,
      ),
    );
  }

  capacityChanged(String capacity) {
    return emit(
      TableEditChanged(
        table: state._table.copyWith(capacity: int.tryParse(capacity)),
        reservation: state._reservation,
        firstname: state._firstname,
        email: state._email,
        lastname: state._lastname,
        number: state._number,
      ),
    );
  }

  firstNameChanged(String firstname) {
    return emit(
      TableEditChanged(
        table: state._table,
        reservation: state._reservation.copyWith(firstname: firstname),
        firstname: Username.dirty(firstname),
        email: state._email,
        lastname: state._lastname,
        number: state._number,
      ),
    );
  }

  lastNameChanged(String lastname) {
    return emit(
      TableEditChanged(
        table: state._table,
        reservation: state._reservation.copyWith(lastname: lastname),
        firstname: state._firstname,
        email: state._email,
        lastname: Username.dirty(lastname),
        number: state._number,
      ),
    );
  }

  mobileChanged(String mobile) {
    return emit(
      TableEditChanged(
        table: state._table,
        reservation: state._reservation.copyWith(mobile: mobile),
        firstname: state._firstname,
        email: state._email,
        lastname: state._lastname,
        number: PhoneNumber.dirty(mobile),
      ),
    );
  }

  emailChanged(String email) {
    return emit(
      TableEditChanged(
        table: state._table,
        reservation: state._reservation.copyWith(email: email),
        firstname: state._firstname,
        email: Email.dirty(email),
        lastname: state._lastname,
        number: state._number,
      ),
    );
  }

  addReservation() async {
    TableReservation table = state._table
        .copyWith(reservation: state._reservation, status: 'RESERVED');
    bool? respnose =
        await _reservationRepository.updateReservation(table.id!, table);
  }
}
