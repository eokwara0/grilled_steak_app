import 'package:billing_repository/billing_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_repository/order_repository.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit({required BillingRepository billingRepository})
      : _billingRepository = billingRepository,
        super(BillInitial());

  final BillingRepository _billingRepository;

  addBill(Order order) async {
    Bill bill = Bill(
      orderId: order.id,
      userId: order.userId,
      grandTotal: order.grandTotal,
    );

    final response = await _billingRepository.addBill(bill);
    if (response) {
      return emit(BillAdded());
    }
    return emit(BillAddError());
  }
}
