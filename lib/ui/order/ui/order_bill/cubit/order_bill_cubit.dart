import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../cubit/order_cubit.dart';

part 'order_bill_state.dart';

class OrderBillCubit extends Cubit<OrderBillState> {
  final OrderCubit _orderCubit;
  final OrderState _orderState;
  OrderBillCubit({
    required OrderCubit orderCubit,
    required OrderState orderState,
  })  : _orderCubit = orderCubit,
        _orderState = orderState,
        super(
          OrderBillInitial(state: orderState),
        );

  Future<void> settleBill(order) async {
    await _orderCubit.closeOrder(order);
    emit(state);
  }

  reset() {
    emit(
      OrderBillInitial(state: _orderCubit.state),
    );
  }
}
