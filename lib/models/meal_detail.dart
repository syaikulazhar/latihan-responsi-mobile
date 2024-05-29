class MealDetail {
  final String idMeal;
  final String strMeal;
  final String? strCategory; // Allow null
  final String? strArea; // Allow null
  final String? strInstructions; // Allow null
  final String? strMealThumb; // Allow null
  final String? strTags; // Allow null
  final String? strYoutube; // Allow null

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
    );
  }
}
