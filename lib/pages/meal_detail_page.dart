import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';

class MealDetailPage extends StatefulWidget {
  final String mealId;

  MealDetailPage({required this.mealId});

  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  late Future<MealDetail> mealDetail;

  @override
  void initState() {
    super.initState();
    mealDetail = ApiService().fetchMealDetail(widget.mealId);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: FutureBuilder<MealDetail>(
        future: mealDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No detail found'));
          } else {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(meal.strMealThumb ?? 'https://via.placeholder.com/150'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      meal.strMeal,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (meal.strInstructions != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        meal.strInstructions!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  if (meal.strTags != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tags: ${meal.strTags!}',
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
                  if (meal.strYoutube != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL(meal.strYoutube!),
                        child: Text(
                          'Watch on YouTube',
                          style: TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
