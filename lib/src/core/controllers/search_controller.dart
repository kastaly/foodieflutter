import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/services/api_service.dart';

class SearchFormController extends GetxController {
  final search = TextEditingController();
  final apiService = ApiService();

  @override
  void onInit() {
    searchListener();
    super.onInit();
  }

  var hasTxtSearch = false.obs;
  var searchResults = <RecipeModel>[].obs;
  var searchHistory = <String>[].obs;
  var hoveredChoice = ''.obs;

  void searchListener() {
    search.addListener(() {
      if (search.text.isNotEmpty) {
        hasTxtSearch.value = true;
      } else {
        hasTxtSearch.value = false;
        clearSearchResults();
      }
    });
  }

  void clearForm() {
    search.clear();
    clearSearchResults();
  }

  void clearSearchResults() {
    searchResults.clear();
  }

  var isFilter = false.obs;

  void filter() => isFilter.value = true;

  void searchRecipes(String query) async {
    try {
      var results = await apiService.searchRecipes(query);
      searchResults.value = results;
      addToSearchHistory(query);
    } catch (e) {
      print('Error searching recipes: $e');
    }
  }

  void addToSearchHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      searchHistory.add(query);
    }
  }

  void removeFromSearchHistory(String query) {
    searchHistory.remove(query);
  }

  void clearSearchHistory() {
    searchHistory.clear();
  }
}
