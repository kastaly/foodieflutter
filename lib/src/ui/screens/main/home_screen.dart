import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/src/ui/screens/recipe/favorites_screen.dart';
import 'package:recipe_app/src/ui/screens/recipe/popular_recipe_sceen.dart';
import 'package:recipe_app/src/ui/screens/search/search_form_screen.dart';
import 'package:recipe_app/src/ui/screens/main/dashboard_screen.dart';
import 'package:recipe_app/src/ui/utils/helper_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List pages
    List<Widget> pages = [
      const DashboardScreen(),
      const PopularRecipeScreen(),
      const SearchFormScreen(),
      const FavoriteScreen(),  // Add the favorites screen here
    ];

    final navC = Get.put(NavbarController());

    return Obx(
      () => Scaffold(
        body: pages.elementAt(navC.index.value),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0.5,
          shape: const CircularNotchedRectangle(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.white,
              child: BottomNavigationBar(
                selectedItemColor: AppColors.primary,
                selectedFontSize: 12,
                currentIndex: navC.index.value,
                onTap: (index) {
                  navC.setIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: SvgPicture.asset(
                      AssetIcons.home,
                      color: navC.index.value == 0
                          ? AppColors.primary
                          : AppColors.secondaryText,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "All recipes",
                    icon: SvgPicture.asset(
                      AssetIcons.camera,
                      color: navC.index.value == 1
                          ? AppColors.primary
                          : AppColors.secondaryText,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Search",
                    icon: SvgPicture.asset(
                      AssetIcons.search,
                      color: navC.index.value == 2
                          ? AppColors.primary
                          : AppColors.secondaryText,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Favorites",
                    icon: Icon(
                      Icons.favorite,
                      color: navC.index.value == 3
                          ? AppColors.primary
                          : AppColors.secondaryText,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Logout",
                    icon: Icon(
                      Icons.logout,
                      color: navC.index.value == 4
                          ? AppColors.primary
                          : AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavbarController extends GetxController {
  var index = 0.obs;

  void setIndex(int page) {
    if (page == 4) {
      // Handle logout
      Get.toNamed('/auth/login');
    } else {
      index.value = page;
    }
  }
}
