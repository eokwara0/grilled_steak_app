import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';

part 'chef_home_page_state.dart';

class ChefHomePageCubit extends Cubit<ChefHomePageState> {
  ChefHomePageCubit(
      {required OrderRepository orderRepo,
      required MenuItemRepository menuItemRepo})
      : _orderRepository = orderRepo,
        _menuItemRepository = menuItemRepo,
        super(const ChefHomePageInitial(
          orders: [],
          menuOrderItems: [],
        )) {
    initialize();
  }

  final OrderRepository _orderRepository;
  final MenuItemRepository _menuItemRepository;

  Future<void> initialize() async {
    List<Order>? orders = await _orderRepository.getUnprepared();
    List<List<MenuItem>> items = [];
    if (orders != null) {
      for (Order order in orders) {
        List<MenuItem> items_ = [];
        for (OrderItem el in order.items) {
          MenuItem? item = await _menuItemRepository.getMenuItemById(el.menuId);
          if (item != null) {
            items_.add(item);
          }
        }
        items.add(items_);
      }
      return emit(
        ChefHomePageLoaded(
          orders: orders,
          menuOrderItems: items,
        ),
      );
    }

    return emit(
      const ChefHomePageError(
        orders: [],
        menuOrderItems: [],
      ),
    );
  }

  Future<void> readyOrder(Order order) async {
    bool response = await _orderRepository.readyOrder(order.id);
    int index = state.orders.indexOf(order);
    List<Order> orders = [...state.orders];
    orders.removeAt(index);
    List<List<MenuItem>> items = [...state._menuOrderItems];
    items.removeAt(index);

    if (response) {
      emit(
        ChefHomePageReadyOrder(
          orders: orders,
          menuOrderItems: items,
        ),
      );
      emit(ChefHomePageLoaded(orders: orders, menuOrderItems: items));
    } else {
      return emit(
        const ChefHomePageError(
          orders: [],
          menuOrderItems: [],
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
        ChefHomePageCancelOrder(
          orders: orders,
          menuOrderItems: items,
        ),
      );

      emit(ChefHomePageLoaded(orders: orders, menuOrderItems: items));
    } else {
      return emit(
        ChefHomePageError(
          orders: state.orders,
          menuOrderItems: state.menuOrderItems,
        ),
      );
    }
  }
}
