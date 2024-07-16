import 'package:flutter/material.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/core/models/user_model.dart';
import 'package:recipe_app/src/services/api_service.dart';
import 'package:recipe_app/src/ui/widgets/recipe_widget.dart';

class UserRecipeScreen extends StatefulWidget {
  const UserRecipeScreen({Key? key}) : super(key: key);

  @override
  _UserRecipeScreenState createState() => _UserRecipeScreenState();
}

class _UserRecipeScreenState extends State<UserRecipeScreen> {
  final ApiService apiService = ApiService();
  List<RecipeModel> recipes = [];
  UserModel? user;
  bool isLoading = true;
  final int userId = 1; // Assign the appropriate userId here

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (!mounted) return; // Check if the widget is still mounted

    try {
      var fetchedRecipes = await apiService.fetchRecipes();
      var fetchedUser = await apiService.fetchUserDetails(userId); // Fetch user details

      if (!mounted) return; // Check again after async operation

      setState(() {
        recipes = fetchedRecipes;
        user = fetchedUser;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // Check in case of error
      setState(() {
        isLoading = false;
      });

      // Handle error, e.g., show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Recipes'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 300,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext ctx, index) {
                if (user != null) {
                  return RecipeWidget(user: user!, data: recipes[index]);
                } else {
                  return const SizedBox(); // Handle case where user is not yet loaded
                }
              },
            ),
    );
  }
}
