import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
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
            status: FormzStatus.invalid,
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
        status: FormzStatus.invalid,
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
          status: Formz.validate([
            state._firstname!,
            state._lastname!,
            state._number!,
            state.email!,
          ])),
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
        status: FormzStatus.invalid,
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
        status: state.reservation.hasDate
            ? Formz.validate([
                Username.dirty(firstname),
                state._lastname!,
                state._number!,
                state.email!,
              ])
            : FormzStatus.invalid,
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
        status: state.reservation.hasDate
            ? Formz.validate([
                Username.dirty(lastname),
                state._firstname!,
                state._number!,
                state._email!
              ])
            : FormzStatus.invalid,
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
        status: state.reservation.hasDate
            ? Formz.validate([
                PhoneNumber.dirty(mobile),
                state._firstname!,
                state._lastname!,
                state._email!
              ])
            : FormzStatus.invalid,
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
        status: state.reservation.hasDate
            ? Formz.validate(
                [
                  Email.dirty(email),
                  state._lastname!,
                  state.firstname!,
                  state._email!
                ],
              )
            : FormzStatus.invalid,
      ),
    );
  }

  addReservation(bool show) async {
    TableReservation table = state._table.copyWith(
      reservation: show ? state._reservation : null,
      status: show ? 'RESERVED' : state.table.status,
    );
    bool response =
        await _reservationRepository.updateReservation(table.id!, table);

    if (response) {
      return emit(
        TableEditSubmit(
          table: table,
          reservation: state._reservation,
          status: FormzStatus.submissionSuccess,
          firstname: state._firstname,
          email: state._email,
          lastname: state._lastname,
          number: state._number,
        ),
      );
    }
    return emit(
      TableEditError(
        table: state.table,
        reservation: state._reservation,
        firstname: state._firstname,
        email: state._email,
        lastname: state._lastname,
        number: state._number,
        status: FormzStatus.submissionFailure,
      ),
    );
  }
}
