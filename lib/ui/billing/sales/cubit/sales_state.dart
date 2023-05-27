part of 'sales_cubit.dart';

abstract class SalesState extends Equatable {
  const SalesState(this.bills, this.users, this.orders);

  final List<Bill> bills;
  final List<User> users;
  final List<Order> orders;

  bool get isInitial => this is SalesInitial;
  bool get isError => this is SalesError;
  bool get isLoaded => this is SalesLoaded;

  @override
  List<Object> get props => [bills, users, orders];
}

class SalesInitial extends SalesState {
  const SalesInitial(super.bills, super.users, super.orders);
}

class SalesLoaded extends SalesState {
  const SalesLoaded(super.bills, super.users, super.orders);
}

class SalesError extends SalesState {
  const SalesError(super.bills, super.users, super.orders);
}
