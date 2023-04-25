// menu item

import 'package:equatable/equatable.dart';

part 'item_model.dart';
part 'nutrition.dart';
part 'recipe.dart';

class MenuItem extends Equatable {
  final String _id;
  final bool? _active;
  final String? _userId;
  final String? _menuId;
  final Item? _item;

  const MenuItem({
    required String id,
    bool? active,
    String? userId,
    String? menuId,
    Item? item,
  })  : _id = id,
        _active = active,
        _userId = userId,
        _item = item,
        _menuId = menuId;

  // Getters
  get id => _id;
  get active => _active;
  get userId => _userId;
  get menuId => _menuId;
  get item => _item;

  @override
  List<Object?> get props => [
        _id,
        _active,
        _userId,
        _menuId,
        _item,
      ];

  Map<String, dynamic> toJson() => {
        'active': _active,
        'userId': _userId,
        'menuId': _menuId,
        'item': _item?.toJson(),
      };

  static empty() {
    return MenuItem(id: '');
  }

  static fromJson(Map<dynamic, dynamic> props) {
    return MenuItem(
      id: props['_id'],
      active: props['active'],
      userId: props['userId'],
      menuId: props['menuId'],
      item: Item.fromJson(
        props['item'],
      ),
    );
  }
}

// items

