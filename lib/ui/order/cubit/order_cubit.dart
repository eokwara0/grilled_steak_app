import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required OrderRepository orderRepo,
    required MenuItemRepository menuItemRepo,
    required UserRepository userRepository,
  })  : _menuItemRepository = menuItemRepo,
        _orderRepository = orderRepo,
        _userRepository = userRepository,
        super(const OrderInitial(
          menuOrderItems: [],
          orders: [],
        )) {
    initialize();
  }

  final OrderRepository _orderRepository;
  final MenuItemRepository _menuItemRepository;
  final UserRepository _userRepository;

  Future<void> initialize() async {
    User? user = await _userRepository.getUser();

    if (user != null) {
      List<Order>? orders = await _orderRepository.getOrdersByUserId(user.id!);
      List<List<MenuItem>> items = [];
      if (orders != null) {
        for (Order order in orders) {
          List<MenuItem> items_ = [];
          for (OrderItem el in order.items) {
            MenuItem? item =
                await _menuItemRepository.getMenuItemById(el.menuId);
            if (item != null) {
              items_.add(item);
            }
          }
          items.add(items_);
        }
        return emit(
          OrderLoaded(
            orders: orders,
            menuOrderItems: items,
          ),
        );
      }

      return emit(
        OrderError(
          orders: state._orders,
          menuOrderItems: state._menuOrderItems,
        ),
      );
    }
  }

  Future<void> orderAgain(
    Order order,
  ) async {
    bool response =
        await _orderRepository.placeOrder(order.copyWith(status: 'PREPARING'));

    if (response) {
      emit(
        OrderAgain(
          orders: state._orders,
          menuOrderItems: state.menuOrderItems,
        ),
      );
      await initialize();
    } else {
      return emit(
        OrderError(
          orders: state.orders,
          menuOrderItems: state._menuOrderItems,
        ),
      );
    }
  }

  Future<void> cancelOrder(Order order) async {
    bool response = await _orderRepository.cancelId(order.id);
    int index = state.orders.indexOf(order);
    List<Order> orders = [...state.orders];
    orders.removeAt(index);
    List<List<MenuItem>> items = [...state._menuOrderItems];
    items.removeAt(index);

    if (response) {
      emit(
        OrderCancel(
          orders: orders,
          menuOrderItems: items,
        ),
      );

      return emit(
        OrderLoaded(
          orders: orders,
          menuOrderItems: items,
        ),
      );
    } else {
      return emit(
        OrderError(
          orders: state.orders,
          menuOrderItems: state._menuOrderItems,
        ),
      );
    }
  }

  Future<void> closeOrder(Order order) async {
    bool response = await _orderRepository.closeId(order.id);
    int index = state.orders.indexOf(order);
    List<Order> orders = [...state.orders];
    orders.removeAt(index);
    List<List<MenuItem>> items = [...state._menuOrderItems];
    items.removeAt(index);

    if (response) {
      emit(
        OrderClosed(
          orders: orders,
          menuOrderItems: items,
        ),
      );

      return emit(
        OrderLoaded(
          orders: orders,
          menuOrderItems: items,
        ),
      );
    } else {
      return emit(
        OrderError(
          orders: state.orders,
          menuOrderItems: state._menuOrderItems,
        ),
      );
    }
  }
}
