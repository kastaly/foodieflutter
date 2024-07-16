import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/src/core/controllers/search_controller.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/ui/screens/recipe/detail_recipe_screen.dart';
import 'package:recipe_app/src/ui/utils/helper_util.dart';
import 'package:recipe_app/src/ui/widgets/component_widget.dart';
import 'package:recipe_app/src/ui/widgets/helper_widget.dart';

class SearchFormScreen extends StatelessWidget {
  const SearchFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> choice = ['Chocolate', 'Meat', 'Salad', 'Pasta'];
    final SearchFormController filterC = Get.put(SearchFormController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
        () => ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                Flexible(
                  child: searchForm(context: context, filterC: filterC),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    child: SvgPicture.asset(AssetIcons.filter),
                    onTap: () => bottomFilter(context),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: divider(),
            ),
            filterC.searchResults.isNotEmpty
                ? Column(
                    children: filterC.searchResults
                        .map((recipe) => RecipeWidget(recipe: recipe))
                        .toList(),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Search History', style: TextTypography.mH2),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: buildSearchHistory(filterC),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        child: divider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Search Suggestions', style: TextTypography.mH2),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: buildFilter(choice, filterC),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future bottomFilter(BuildContext context) {
    List<String> choice = ['All', 'Food', 'Drink'];
    final filterCtrl = Get.put(SearchFormController());
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const Text('Add a Filter', style: TextTypography.mH2),
              ),
            ),
            const Text('Category', style: TextTypography.mH2),
            buildFilter(choice, filterCtrl),
            richLabel(title1: 'Cooking Duration', title2: ' (in minutes)'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('<10', style: TextTypography.p1Primary),
                Text('30', style: TextTypography.p1Primary),
                Text('>60', style: TextTypography.p1Primary)
              ],
            ),
            buildSlider(),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDefault(
                  width: SizeConfig().deviceWidth(context) / 2.5,
                  onPressed: () {
                    Get.back();
                  },
                  txtButton: 'Cancel',
                ),
                Button(
                  disable: false,
                  width: SizeConfig().deviceWidth(context) / 2.5,
                  onPressed: () {
                    filterCtrl.filter();
                    Get.back();
                  },
                  txtButton: 'Done',
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
      elevation: 20.0,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
    );
  }

  Widget buildFilter(List<String> choices, SearchFormController filterC) {
    return Wrap(
      spacing: 8.0,
      children: choices.map((choice) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => filterC.hoveredChoice.value = choice,
          onExit: (_) => filterC.hoveredChoice.value = '',
          child: Obx(() {
            bool isHovered = filterC.hoveredChoice.value == choice;
            return GestureDetector(
              onTap: () {
                filterC.searchRecipes(choice);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isHovered ? Colors.grey[200] : Colors.white,
                  border: Border.all(
                    color: isHovered ? Colors.green : Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  choice,
                  style: TextStyle(
                    color: isHovered ? Colors.green : Colors.green,
                  ),
                ),
              ),
            );
          }),
        );
      }).toList(),
    );
  }

  Widget buildSearchHistory(SearchFormController filterC) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filterC.searchHistory.map((query) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(query, style: TextStyle(color: Colors.black)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  filterC.removeFromSearchHistory(query);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

 Widget searchForm({required BuildContext context, required SearchFormController filterC}) {
  return TextField(
    controller: filterC.search,
    decoration: InputDecoration(
      hintText: 'Search',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIcon: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          filterC.clearForm();
        },
      ),
    ),
    onSubmitted: (value) {
      if (value.isNotEmpty) {
        filterC.searchRecipes(value);
      }
    },
    onChanged: (value) {
      if (value.isEmpty) {
        filterC.clearSearchResults();
      }
    },
  );
}

}

class RecipeWidget extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeWidget({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(recipe.image),
      title: Text(recipe.title),
      subtitle: Text(recipe.user.name),
      onTap: () {
        Get.to(() => RecipeDetailScreen(recipe: recipe));
      },
    );
  }
}
