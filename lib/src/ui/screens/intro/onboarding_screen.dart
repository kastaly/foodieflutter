import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/src/ui/utils/helper_util.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: SizeConfig().deviceWidth(context),
            height: SizeConfig().deviceHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetImages.onboardingImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            width: SizeConfig().deviceWidth(context),
            height: SizeConfig().deviceHeight(context),
            color: Colors.black.withOpacity(0.6),
          ),
          // Content
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig().deviceHeight(context) * 0.2),
                  const Text(
                    'Start Cooking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      'Let’s join FoodieHub to cook better food!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Positioned button at the bottom
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/auth/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 204, 138, 31),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
