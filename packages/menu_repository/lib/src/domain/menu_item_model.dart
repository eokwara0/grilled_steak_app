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
  final String? _imageUrl;

  const MenuItem({
    required String id,
    bool? active,
    String? userId,
    String? menuId,
    Item? item,
    String? imageUrl,
  })  : _id = id,
        _active = active,
        _userId = userId,
        _item = item,
        _menuId = menuId,
        _imageUrl = imageUrl;

  // Getters
  String get id => _id;
  bool? get active => _active;
  String? get userId => _userId;
  String? get menuId => _menuId;
  Item? get item => _item;
  String? get imageUrl => _imageUrl;

  @override
  List<Object?> get props => [
        _id,
        _active,
        _userId,
        _menuId,
        _item,
        _imageUrl,
      ];

  Map<String, dynamic> toJson() => {
        "active": _active,
        "userId": _userId,
        "menuId": _menuId,
        "item": _item?.toJson(),
        'imageUrl': _imageUrl,
      };

  static empty(String? userId, String? menuId) {
    bool active = true;
    String imageUrl = "";
    Item item_ = Item.empty();

    return MenuItem(
      id: '',
      menuId: menuId,
      userId: userId,
      active: active,
      imageUrl: imageUrl,
      item: item_,
    );
  }

  static fromJson(Map<dynamic, dynamic> props) {
    return MenuItem(
      id: '${props['_id']}',
      active: props['active'],
      userId: '${props['userId']}',
      menuId: '${props['menuId']}',
      imageUrl: '${props['imageUrl']}',
      item: Item.fromJson(
        props['item'],
      ),
    );
  }

  copyWith({
    bool? active,
    String? imageUrl,
    Item? item,
  }) {
    return MenuItem(
      id: _id,
      userId: _userId,
      menuId: _menuId,
      item: item ?? _item,
      active: active ?? _active,
      imageUrl: imageUrl ?? _imageUrl,
    );
  }

  @override
  String toString() => toJson().toString();
}



// items

