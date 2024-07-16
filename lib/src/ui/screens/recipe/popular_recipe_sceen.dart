import 'package:flutter/material.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/services/api_service.dart';
import 'package:recipe_app/src/ui/widgets/recipe_widget.dart';

class PopularRecipeScreen extends StatefulWidget {
  const PopularRecipeScreen({super.key});

  @override
  _PopularRecipeScreenState createState() => _PopularRecipeScreenState();
}

class _PopularRecipeScreenState extends State<PopularRecipeScreen> {
  final ApiService apiService = ApiService();
  List<RecipeModel> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      var fetchedRecipes = await apiService.fetchRecipes();
      if (!mounted) return;
      setState(() {
        recipes = fetchedRecipes;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recipes'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 300,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: recipes.length,
                itemBuilder: (BuildContext ctx, index) {
                  return RecipeWidget(data: recipes[index], user: recipes[index].user);
                },
              ),
            ),
    );
  }
}
