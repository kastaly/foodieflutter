import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/src/core/models/helper_model.dart';

class FavoriteManager {
  static const _favoritesKey = 'favorites';
  static final _storage = GetStorage();

  List<RecipeModel> getFavorites() {
    List<dynamic>? favoritesJson = _storage.read<List<dynamic>>(_favoritesKey);
    if (favoritesJson == null) {
      return [];
    }
    List<RecipeModel> favorites = favoritesJson.map((json) => RecipeModel.fromJson(json)).toList();
    return favorites;
  }

  static void addFavorite(RecipeModel recipe) {
    List<RecipeModel> favorites = FavoriteManager().getFavorites();

    if (!favorites.any((fav) => fav.id == recipe.id)) {
      favorites.add(recipe);
      _storage.write(_favoritesKey, favorites.map((fav) => fav.toJson()).toList());
    }
  }
}


