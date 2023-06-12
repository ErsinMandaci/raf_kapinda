//define routes here
import 'package:flutter/cupertino.dart';
import 'package:groceries_app/features/account/account_item/orders.dart';
import 'package:groceries_app/features/auth/sign_in_page.dart';
import 'package:groceries_app/features/auth/sign_up_page.dart';
import 'package:groceries_app/features/explore/category_filter.dart';
import 'package:groceries_app/features/explore/explore_page.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';
import 'package:groceries_app/features/home/home_page.dart';
import 'package:groceries_app/features/onboarding/onboarding_view.dart';
import 'package:groceries_app/features/product_detail/product_detail.dart';

import '../../features/auth/landing_page.dart';
import '../../features/auth/log_in_page.dart';
import '../widgets/auth_widget/auth_checker-widget.dart';

//Route name constants

const String signInPage = 'sign-in';
const String onBoarding = 'onboarding';
const String loginPage = 'login';
const String signUp = 'signUp';
const String landingPage = 'landing';
const String homePage = 'home';
const String authChecker = 'authChecker';
const String explore = 'explore';
const String bottomPageBuilder = 'bottomPageBuilder';
const String detailPage = 'detail';
const String settingsPage = 'settings';
const String categoryFilter = 'categoryFilter';
const String orders = 'orders';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case landingPage:
      return CupertinoPageRoute(builder: (context) => const LandingPage());
    case signInPage:
      return CupertinoPageRoute(builder: (context) => const SignInPage());
    case onBoarding:
      return CupertinoPageRoute(builder: (context) => const OnboardingView());
    case loginPage:
      return CupertinoPageRoute(builder: (context) => LogInPage());

    case signUp:
      return CupertinoPageRoute(builder: (context) => SignUpPage());

    case homePage:
      return CupertinoPageRoute(builder: (context) => const HomePage());
    case authChecker:
      return CupertinoPageRoute(builder: (context) => const AuthChecker());

    case explore:
      return CupertinoPageRoute(builder: (context) => ExplorePage());
    case detailPage:
      return CupertinoPageRoute(
          builder: (context) => const ProductDetailPage());
    case bottomPageBuilder:
      return CupertinoPageRoute(
          builder: (context) => const BottomPageBuilder());

    case categoryFilter:
      return CupertinoPageRoute(
          builder: (context) => const CategoryFilterPage());

    case orders:
      return CupertinoPageRoute(builder: (context) => const OrdersPage());

    default:
      throw const FormatException('Route not found');
  }
}
