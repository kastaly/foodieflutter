import 'package:flutter/material.dart';
import 'package:recipe_app/src/ui/utils/helper_util.dart';
import 'package:recipe_app/src/ui/widgets/helper_widget.dart';
import 'package:recipe_app/src/core/models/category_model.dart';
import 'package:recipe_app/src/services/api_service.dart';
import '../recipe/popular_recipe_sceen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<CategoryModel> categories = [];
  bool isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    // Load special offers immediately
    fetchSpecialOffers();
  }

  Future<void> fetchSpecialOffers() async {
    // Simulating API call delay with Future.delayed
    await Future.delayed(Duration(seconds: 1));
    // Once special offers are loaded, then start fetching categories
    setState(() {
      isLoadingCategories = false;
    });
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      ApiService apiService = ApiService();
      List<CategoryModel> fetchedCategories = await apiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Failed to load categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchForm(context: context, redirect: true),
                  const SizedBox(height: 20),
                  // Special Offers Card
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/special_offers_image.jpg', // Replace with your image path
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Special Offers',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Check out our latest recipes with the best chefs ! healthier and even way better!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to special offers screen
                                  },
                                  child: Text('Check recipes'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: const Text('Category', style: TextTypography.mH2),
                  ),
                  isLoadingCategories
                      ? CircularProgressIndicator()
                      : buildFilter(categories.map((category) => category.name).toList()),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: divider(),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: AppColors.outline),
                      ),
                    ),
                    child: const TabBar(
                      labelColor: AppColors.titleText,
                      unselectedLabelColor: AppColors.secondaryText,
                      indicatorColor: AppColors.primary,
                      indicatorWeight: 3,
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: <Widget>[Tab(text: "Popular"), Tab(text: "New")],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: const TabBarView(
                        children: <Widget>[
                          PopularRecipeScreen(),
                          PopularRecipeScreen(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFilter(List<String> choices) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    children: choices.map((choice) {
      return ChoiceChip(
        label: Text(choice),
        selected: false,
        onSelected: (selected) {
          // Handle selection
        },
      );
    }).toList(),
  );
}
