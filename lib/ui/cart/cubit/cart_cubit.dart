import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';

import '../../login/models/email.dart';
import '../../login/models/username.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
      {required OrderRepository orderRepo,
      required MenuItemRepository menuRepo})
      : _orderRepository = orderRepo,
        _menuItemRepository = menuRepo,
        super(
          CartInitial(
            orderItems: const [],
            menuItems: const [],
            email: const Email.dirty(''),
            username: const Username.dirty(''),
          ),
        ) {
    _loadItems();
  }

  final OrderRepository _orderRepository;
  final MenuItemRepository _menuItemRepository;

  void addOrderItem(OrderItem item) {
    List<OrderItem> items = [...state._orderItems];
    items = _checkIfItemInList(items, item);
    emit(
      CartItemAdded(
        orderItems: items,
        menuItems: const [],
        email: state._email,
        username: state.username,
      ),
    );
    _loadItems();
  }

  void replaceOrderItem(OrderItem oldItem, OrderItem newItem) {
    List<OrderItem> items = [...state._orderItems];
    int index = items.indexOf(oldItem);
    items.replaceRange(index, index + 1, [newItem]);
    return emit(
      CartChanged(
        orderItems: items,
        menuItems: state.menuItems,
        email: state._email,
        username: state._username,
      ),
    );
  }

  void removeItem(OrderItem item, MenuItem menuItem) {
    List<OrderItem> orderItems = [...state.orderItems];
    List<MenuItem> menuItems = [...state.menuItems];

    orderItems.remove(item);
    menuItems.remove(menuItem);

    emit(
      CartMenuItemLoaded(
        orderItems: [...orderItems],
        menuItems: [...menuItems],
        email: state._email,
        username: state._username,
      ),
    );
    // _loadItems();
  }

  void _loadItems() {
    List<MenuItem> menuItems = [];
    state._orderItems.forEach((el) async {
      MenuItem? item = await _menuItemRepository.getMenuItemById(el.menuId);
      menuItems.add(item!);
    });

    emit(
      CartMenuItemLoaded(
        orderItems: state.orderItems,
        menuItems: menuItems,
        email: state._email,
        username: state._username,
      ),
    );
  }

  void onEmailChanged(String email) {
    return emit(
      CartMenuItemLoaded(
        orderItems: state.orderItems,
        menuItems: state.menuItems,
        email: Email.dirty(email),
        username: state._username,
      ),
    );
  }

  void onNameChanged(String name) {
    return emit(
      CartMenuItemLoaded(
        orderItems: state.orderItems,
        menuItems: state.menuItems,
        email: state.email,
        username: Username.dirty(name),
      ),
    );
  }

  void reset() {
    return emit(
      CartMenuItemLoaded(
        orderItems: const [],
        menuItems: const [],
        email: const Email.dirty(''),
        username: const Username.dirty(''),
      ),
    );
  }

  List<OrderItem> _checkIfItemInList(
    List<OrderItem> items,
    OrderItem item,
  ) {
    OrderItem? found;

    for (OrderItem orderItem in items) {
      if (orderItem.menuId == item.menuId) {
        found = orderItem;
      }
    }

    if (found != null) {
      final newFound = found.copyWith(
        quantity: found.quantity + item.quantity,
      );
      items.remove(found);
      items.add(newFound);
    } else {
      items.add(item);
    }
    return items;
  }

  void checkOut(String userId) async {
    Order order = Order(
      id: '',
      userId: userId,
      type: 'EAT-IN',
      status: 'PREPARING',
      grandTotal: state.grandTotal,
      items: state.orderItems,
      customer: OrderCustomer(
        name: state.username!.value,
        email: state._email!.value,
      ),
    );

    bool res = await _orderRepository.placeOrder(order);
    if (res) {
      emit(
        CartCheckedOut(
          orderItems: state._orderItems,
          menuItems: state._menuItems,
          email: state._email,
          username: state._username,
        ),
      );

      return reset();
    }
    return emit(
      CartError(
        orderItems: state.orderItems,
        menuItems: state.menuItems,
        email: state.email,
        username: state.username,
      ),
    );
  }
}
