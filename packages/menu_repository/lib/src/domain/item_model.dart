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

  get unit => _unit;
  get price => _price;
  get prep => _prep;
  get title => _title;
  get cooking => _cooking;
  get summary => _summary;
  get content => _content;
  get quantity => _quantity;
  get recipe => _recipe;
  get nutrition => _nutrition;
  get instructions => _instructions;

  static fromJson(Map<dynamic, dynamic> json) {
    final res = List.of(json['recipe']);
    final recipeList_ = res
        .map(
          (el) => Recipe.fromJson(
            el,
          ),
        )
        .toList();
    final Nutrition nut = Nutrition.fromJson(
      json['nutrition'],
    );

    return Item(
      title: json['title'],
      summary: json['summary'],
      cooking: json['cooking'],
      price: double.tryParse('${json['price']}'),
      quantity: double.tryParse('${json['quantity']}'),
      unit: json['unit'],
      prep: json['prep'],
      recipe: recipeList_,
      nutrition: nut,
      content: json['content'],
      instructions: json['instructions'],
    );
  }
}
