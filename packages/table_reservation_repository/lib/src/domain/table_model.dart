import 'package:equatable/equatable.dart';
import 'package:table_reservation_repository/src/domain/reservation.dart';

class TableReservation extends Equatable {
  final String? _id;
  final String? _status;
  final int? _capacity;
  final Reservation? _reservation;
  const TableReservation({
    String? id,
    String? status,
    int? capacity,
    Reservation? reservation,
  })  : _id = id,
        _status = status,
        _capacity = capacity,
        _reservation = reservation;

  String? get id => _id;
  String? get status => _status;
  int? get capacity => _capacity;
  Reservation? get reservation => _reservation;

  static fromJson(Map<dynamic, dynamic> json) {
    return TableReservation(
      id: '${json['_id']}',
      status: '${json['status']}',
      capacity: json['capacity'],
      reservation: Reservation.fromJson(
        json['reservation'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": _status,
        "capacity": _capacity,
        "reservation": _reservation!.hasDate ? _reservation?.toJson() : {},
      };

  copyWith({
    String? id,
    String? status,
    int? capacity,
    Reservation? reservation,
  }) {
    return TableReservation(
      id: id ?? _id,
      status: status ?? _status,
      capacity: capacity ?? _capacity,
      reservation: reservation ?? _reservation,
    );
  }

  // props
  @override
  List<Object?> get props => [
        _id,
        _status,
        _capacity,
        _reservation,
      ];
}
