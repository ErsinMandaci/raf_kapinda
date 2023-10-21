import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';

import '../../features/account/account_item/orders_page.dart';
import '../../features/account/account_page.dart';
import '../../features/auth/landing_page.dart';
import '../../features/auth/log_in_page.dart';
import '../../features/auth/sign_in_page.dart';
import '../../features/auth/sign_up_page.dart';
import '../../features/card/cart_page.dart';
import '../../features/explore/category_filter_page.dart';
import '../../features/explore/explore_page.dart';
import '../../features/favourite/favourite.dart';
import '../../features/home/home_page.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/product_detail/product_detail.dart';
import '../../features/splash/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: BottomRouteBuilder.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: ExploreRoute.page),
          AutoRoute(page: CartRoute.page),
          AutoRoute(page: FavouriteRoute.page),
          AutoRoute(page: AccountRoute.page),
        ]),
        AutoRoute(page: CategoryFilterRoute.page),
        AutoRoute(page: OrdersRoute.page),
        AutoRoute(page: LandingRoute.page),
        AutoRoute(page: LogInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: ProductDetailRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: SplashRoute.page),
      ];
}
