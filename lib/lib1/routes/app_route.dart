import 'package:firebaseauth111/lib1/model/category.dart';
import 'package:firebaseauth111/lib1/model/product.dart';
import 'package:firebaseauth111/lib1/screens/category_list/category_list_screen.dart';
import 'package:firebaseauth111/lib1/screens/home/home_screen.dart';
import 'package:firebaseauth111/lib1/screens/product_list/product_list_screen.dart';
import 'package:firebaseauth111/lib1/screens/sign_in/sign_in_screen.dart';
import 'package:firebaseauth111/lib1/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/model/category.dart';
// import 'package:shoppio_flutter_app/model/product.dart';
// import 'package:shoppio_flutter_app/screens/category_list/category_list_screen.dart';
// import 'package:shoppio_flutter_app/screens/home/home_screen.dart';
// import 'package:shoppio_flutter_app/screens/product_list/product_list_screen.dart';
// import 'package:shoppio_flutter_app/screens/sign_in/sign_in_screen.dart';
// import 'package:shoppio_flutter_app/screens/sign_up/sign_up_screen.dart';
import '../screens/category/category_screen.dart';
import '../screens/onboarding/on_boarding_screen.dart';
import '../screens/product/product_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoute {
  static const splashScreen = '/';
  static const onBoardingScreen = '/onBoarding';
  static const signInScreen = '/signIn';
  static const signUpScreen = '/signUp';
  static const homeScreen = '/home';
  static const categoryListScreen = '/categoryList';
  static const categoryScreen = '/category';
  static const productListScreen = '/productList';
  static const productScreen = '/product';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );
      case signInScreen:
        return MaterialPageRoute(
          builder: (context) => SignInScreen(),
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case categoryListScreen:
        return MaterialPageRoute(
          builder: (context) => CategoryListScreen(),
        );
      case categoryScreen:
        Category? category = settings.arguments != null ? settings.arguments as Category : null;

        return MaterialPageRoute(
          builder: (context) => CategoryScreen(
            category: category,
          ),
        );
      case productListScreen:
        return MaterialPageRoute(
          builder: (context) => ProductListScreen(),
        );
      case productScreen:

        Product? product = settings.arguments != null ? settings.arguments as Product : null;

        return MaterialPageRoute(
          builder: (context) => ProductScreen(product),
        );
    }
  }
}
