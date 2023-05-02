// Recipes
part of 'menu_item_model.dart';

class Recipe extends Equatable {
  final String? _title;
  final String? _summary;
  final String? _instructions;
  final String? _unit;
  final double? _quantity;

  const Recipe({
    String? title,
    String? summary,
    String? instructions,
    double? quantity,
    final String? units,
  })  : _unit = units,
        _title = title,
        _summary = summary,
        _instructions = instructions,
        _quantity = quantity;

  /// returns a new copy of Recipe
  copyWith({
    String? title,
    String? units,
    String? summary,
    String? instructions,
    double? quantity,
  }) {
    return Recipe(
      title: title ?? _title,
      units: units ?? _unit,
      summary: summary ?? _summary,
      instructions: instructions ?? _instructions,
      quantity: quantity ?? _quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': _title,
        'unit': _unit,
        'summary': _summary,
        'instructions': _instructions,
        'quantity': _quantity
      };

  /// returns recipe from json string
  static Recipe fromJson(Map<dynamic, dynamic> data) {
    return Recipe(
      title: '${data['title']}',
      units: '${data['unit']}',
      summary: '${data["summary"]}',
      instructions: '${data['instructions']}',
      quantity: double.tryParse(
        '${data['quantity']}',
      ),
    );
  }

  String? get title => _title;
  String? get unit => _unit;
  String? get summary => _summary;
  String? get instructions => _instructions;
  double? get quantity => _quantity;

  @override
  List<Object?> get props =>
      [_title, _summary, _instructions, _unit, _quantity];
}
