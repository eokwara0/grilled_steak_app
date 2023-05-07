part of 'menu_item_model.dart';

class Nutrition extends Equatable {
  final String? _fat;
  final String? _carbs;
  final String? _protein;
  final String? _calories;

  const Nutrition({
    String? fat,
    String? carbs,
    String? protein,
    String? calories,
  })  : _fat = fat,
        _carbs = carbs,
        _protein = protein,
        _calories = calories;

  // Getters
  get fat => _fat;
  get carbs => _carbs;
  get protein => _protein;
  get calories => _calories;

  Map<String, String> toJson() => {
        'fat': _fat ?? '',
        'carbs': _carbs ?? '',
        'protein': _protein ?? '',
        'calories': _calories ?? '',
      };

  static empty() {
    return {
      'fat': '0g',
      'carbs': '0g',
      'protein': '0g',
      'calories': '0',
    };
  }

  /// return a copy of the Nutirion object
  copyWith({
    String? fat,
    String? carbs,
    String? protein,
    String? calories,
  }) {
    return Nutrition(
      fat: fat ?? _fat,
      protein: protein ?? _protein,
      carbs: carbs ?? _carbs,
      calories: calories ?? _calories,
    );
  }

  /// returns recipe from json string
  static Nutrition fromJson(Map<dynamic, dynamic> data) {
    return Nutrition(
      fat: '${data["fat"]}',
      carbs: '${data["carbs"]}',
      protein: '${data["protein"]}',
      calories: '${data["calories"]}',
    );
  }

  @override
  List<Object?> get props => [
        _fat,
        _carbs,
        _protein,
        _calories,
      ];
}
