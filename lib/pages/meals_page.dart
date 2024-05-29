import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import 'meal_detail_page.dart';

class MealsPage extends StatefulWidget {
  final String category;

  MealsPage({required this.category});

  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late Future<List<Meal>> meals;

  @override
  void initState() {
    super.initState();
    meals = ApiService().fetchMeals(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Meals'),
      ),
      body: FutureBuilder<List<Meal>>(
        future: meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final meal = snapshot.data![index];
                return ListTile(
                  leading: Image.network(meal.strMealThumb),
                  title: Text(meal.strMeal),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailPage(mealId: meal.idMeal),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
