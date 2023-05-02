part of 'menu_item_model.dart';

class Item extends Equatable {
  final String? _unit;
  final String? _prep;
  final double? _price;
  final String? _title;
  final bool? _cooking;
  final String? _summary;
  final String? _content;
  final double? _quantity;
  final List<Recipe>? _recipe;
  final Nutrition? _nutrition;
  final String? _instructions;

  copyWith({
    String? unit,
    String? prep,
    double? price,
    String? title,
    String? summary,
    String? content,
    double? quantity,
    List<Recipe>? recipe,
    Nutrition? nutrition,
    String? instructions,
  }) {
    return Item(
      cooking: _cooking,
      unit: unit ?? _unit,
      prep: prep ?? _prep,
      price: price ?? _price,
      title: title ?? _title,
      recipe: recipe ?? _recipe,
      summary: summary ?? _summary,
      content: content ?? _content,
      quantity: quantity ?? _quantity,
      nutrition: nutrition ?? _nutrition,
      instructions: instructions ?? _instructions,
    );
  }

  const Item({
    String? unit,
    String? prep,
    double? price,
    String? title,
    bool? cooking,
    String? summary,
    String? content,
    double? quantity,
    List<Recipe>? recipe,
    Nutrition? nutrition,
    String? instructions,
  })  : _unit = unit,
        _prep = prep,
        _price = price,
        _title = title,
        _cooking = cooking,
        _summary = summary,
        _content = content,
        _quantity = quantity,
        _recipe = recipe,
        _nutrition = nutrition,
        _instructions = instructions;

  Map<String, dynamic> toJson() => {
        'unit': _unit,
        'prep': _prep,
        'price': _price,
        'title': _title,
        'cooking': _cooking,
        'summary': _summary,
        'content': _content,
        'quantity': _quantity,
        'recipe': _recipe?.map((e) => e.toJson()).toList(),
        'nutritions': _nutrition?.toJson(),
        'instructions': _instructions
      };
  @override
  List<Object?> get props => [
        _unit,
        _prep,
        _price,
        _title,
        _cooking,
        _summary,
        _content,
        _quantity,
        _recipe,
        _nutrition,
        _instructions
      ];

  String? get unit => _unit;
  double? get price => _price;
  String? get prep => _prep;
  String? get title => _title;
  bool? get cooking => _cooking;
  String? get summary => _summary;
  String? get content => _content;
  double? get quantity => _quantity;
  List<Recipe>? get recipe => _recipe;
  Nutrition? get nutrition => _nutrition;
  String? get instructions => _instructions;

  static fromJson(Map<dynamic, dynamic> json) {
    final res = List.of(json['recipe'] ??= []);
    final recipeList_ = res
        .map(
          (el) => Recipe.fromJson(
            el,
          ),
        )
        .toList();
    final Nutrition nut = Nutrition.fromJson(
      json['nutrition'] ??= {},
    );

    return Item(
      title: '${json['title']}',
      summary: '${json['summary']}',
      cooking: json['cooking'] ?? "",
      price: double.tryParse('${json['price']}'),
      quantity: double.tryParse('${json['quantity']}') ?? 0.0,
      unit: '${json['unit']}',
      prep: '${json['prep']}',
      recipe: recipeList_,
      nutrition: nut,
      content: '${json['content']}',
      instructions: '${json['instructions']}',
    );
  }
}
