import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String? _firstname;
  final String? _lastname;
  final String? _mobile;
  final String? _email;
  final DateTime? _startDate;
  final DateTime? _endDate;

  // constructor
  const Reservation({
    String? firstname,
    String? lastname,
    String? mobile,
    String? email,
    DateTime? startDate,
    DateTime? endDate,
  })  : _firstname = firstname,
        _lastname = lastname,
        _mobile = mobile,
        _email = email,
        _startDate = startDate,
        _endDate = endDate;

  copyWith({
    String? firstname,
    String? lastname,
    String? mobile,
    String? email,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Reservation(
      firstname: firstname ?? _firstname,
      lastname: lastname ?? _lastname,
      mobile: mobile ?? _mobile,
      email: email ?? _email,
      startDate: startDate ?? _startDate,
      endDate: endDate ?? _endDate,
    );
  }

  static fromJson(Map<dynamic, dynamic> json) {
    if (json.isEmpty) {
      return Reservation();
    }
    return Reservation(
      firstname: '${json['firstname']}',
      lastname: '${json['lastname']}',
      mobile: '${json['mobile']}',
      email: '${json['email']}',
      startDate: DateTime.parse('${json['startDate']}'),
      endDate: DateTime.parse('${json['endDate']}'),
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'firstname': _firstname,
        'lastname': _lastname,
        'mobile': _mobile,
        'email': _email,
        'startDate': _startDate.toString(),
        'endDate': _endDate.toString()
      };

  // Getters
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get mobile => _mobile;
  String? get email => _email;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  // checks
  bool get hasDate => startDate != null;

  @override
  List<Object?> get props => [
        _firstname,
        _lastname,
        _mobile,
        _email,
        _startDate,
        _endDate,
      ];
}
