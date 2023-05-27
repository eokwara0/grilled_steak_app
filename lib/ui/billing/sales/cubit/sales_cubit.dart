import 'package:billing_repository/billing_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_repository/order_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit({
    required BillingRepository billingRepository,
    required UserRepository userRepository,
    required OrderRepository orderRepository,
  })  : _billingRepository = billingRepository,
        _userRepository = userRepository,
        _orderRepository = orderRepository,
        super(const SalesInitial([], [], [])) {
    instantiate();
  }

  final BillingRepository _billingRepository;
  final UserRepository _userRepository;
  final OrderRepository _orderRepository;

  Future<void> instantiate() async {
    List<Bill>? bills = await _billingRepository.getBills();
    List<User> users = [];
    List<Order> orders = [];
    if (bills != null) {
      for (Bill b in bills) {
        User? user = await _userRepository.getUserById(b.userId);
        Order? order = await _orderRepository.getOrderById(b.orderId);
        if (user != null && order != null) {
          users.add(user);
          orders.add(order);
        }
      }
      return emit(SalesLoaded(bills, users, orders));
    }
    return emit(const SalesError([], [], []));
  }
}
