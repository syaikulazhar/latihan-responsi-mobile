import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('${_baseUrl}categories.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['categories'];
      return Category.fromJsonList(data);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMeals(String category) async {
    final response = await http.get(Uri.parse('${_baseUrl}filter.php?c=$category'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['meals'];
      return Meal.fromJsonList(data);
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<MealDetail> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['meals'][0];
      return MealDetail.fromJson(data);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }
}
