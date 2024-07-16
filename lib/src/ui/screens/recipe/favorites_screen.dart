// import 'package:flutter/material.dart';
// import 'package:recipe_app/src/core/models/recipe_model.dart';
// import 'package:recipe_app/src/ui/widgets/favorite_manager.dart';

// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorite Recipes'),
//       ),
//       body: FutureBuilder<List<RecipeModel>>(
//         future: FavoriteManager.favorites,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Failed to load favorites'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No favorites yet'));
//           } else {
//             final favoriteRecipes = snapshot.data!;
//             return ListView.builder(
//               itemCount: favoriteRecipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = favoriteRecipes[index];
//                 return ListTile(
//                   leading: Image.network(recipe.imageUrl),
//                   title: Text(recipe.title),
//                   subtitle: Text('Servings: ${recipe.servings}'),
//                   onTap: () {
//                     // Handle navigation to recipe details screen
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/src/core/models/helper_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _storage = GetStorage();
    List<dynamic> favoritesJson =
        _storage.read<List<dynamic>>('favorites') ?? [];
    List<RecipeModel> favorites =
        favoritesJson.map((json) => RecipeModel.fromJson(json)).toList();
    print(favoritesJson);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          RecipeModel recipe = favorites[index];
          return ListTile(
            title: Text(recipe.title),
            subtitle: Text(recipe.title),
            // Implement onTap to handle navigation or further actions
            onTap: () {
              // Example: Navigate to recipe details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Example RecipeDetailsScreen
class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(recipe.title),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
