part of 'order_bill_cubit.dart';

abstract class OrderBillState extends Equatable {
  const OrderBillState({required OrderState state}) : _orderState = state;

  final OrderState _orderState;

  OrderState get bill => _orderState;

  @override
  List<Object> get props => [_orderState];
}

class OrderBillInitial extends OrderBillState {
  const OrderBillInitial({required super.state});
}
