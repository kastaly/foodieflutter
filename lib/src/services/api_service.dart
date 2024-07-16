import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/core/models/category_model.dart';
import 'package:recipe_app/src/core/models/user_model.dart';

class ApiService {
  final String apiUrl = 'http://127.0.0.1:8000/api/recipes';
  final String categoriesUrl = 'http://127.0.0.1:8000/api/categories';
  final String userUrl = 'http://127.0.0.1:8000/api/users';
  final String loginUrl = 'http://127.0.0.1:8000/api/login'; // Add your login URL
  final String baseImageUrl = 'http://127.0.0.1:8000/storage/';

  Future<UserModel> fetchUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$userUrl/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      jsonResponse['user']['profile_picture'] = '$baseImageUrl${jsonResponse['user']['profile_picture']}'.replaceAll(r'\', '/');
      return UserModel.fromJson(jsonResponse['user']);
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<List<RecipeModel>> fetchRecipes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('recipes')) {
        final recipesJson = jsonResponse['recipes'];
        try {
          return (recipesJson as List).map<RecipeModel>((json) {
            json['image'] = '$baseImageUrl${json['image']}'.replaceAll(r'\', '/');
            json['user']['profile_picture'] = '$baseImageUrl${json['user']['profile_picture']}'.replaceAll(r'\', '/');
            return RecipeModel.fromJson(json);
          }).toList();
        } catch (e) {
          throw Exception('Error converting recipes: $e');
        }
      } else {
        throw Exception('Failed to load recipes: Invalid JSON structure');
      }
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('categories')) {
        final categoriesJson = jsonResponse['categories'];
        try {
          return (categoriesJson as List).map<CategoryModel>((json) {
            return CategoryModel.fromJson(json);
          }).toList();
        } catch (e) {
          throw Exception('Error converting categories: $e');
        }
      } else {
        throw Exception('Failed to load categories: Invalid JSON structure');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?search=$query'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('recipes')) {
        final recipesJson = jsonResponse['recipes'];

        try {
          return (recipesJson as List).map<RecipeModel>((json) {
            json['image'] = '$baseImageUrl${json['image']}'.replaceAll(r'\', '/');
            json['user']['profile_picture'] = '$baseImageUrl${json['user']['profile_picture']}'.replaceAll(r'\', '/');
            return RecipeModel.fromJson(json);
          }).toList();
        } catch (e) {
          throw Exception('Error converting recipes: $e');
        }
      } else {
        throw Exception('Failed to load recipes: Invalid JSON structure');
      }
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  // Add this method
  Future<RecipeModel> fetchRecipeById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      jsonResponse['image'] = '$baseImageUrl${jsonResponse['image']}'.replaceAll(r'\', '/');
      jsonResponse['user']['profile_picture'] = '$baseImageUrl${jsonResponse['user']['profile_picture']}'.replaceAll(r'\', '/');
      return RecipeModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load recipe');
    }
  }
  
}
