import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../pages/meals_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    categories = ApiService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<Category>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return ListTile(
                  leading: Image.network(category.strCategoryThumb),
                  title: Text(category.strCategory),
                  subtitle: Text(category.strCategoryDescription),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealsPage(category: category.strCategory),
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
