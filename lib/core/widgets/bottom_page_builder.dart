import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/routes/app_router.dart';

@RoutePage()
final class BottomPageBuilder extends StatelessWidget {
  const BottomPageBuilder();
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      animationDuration: Duration(milliseconds: 1000),
      animationCurve: Curves.bounceOut,
      routes: [
        HomeRoute(),
        ExploreRoute(),
        CartRoute(),
        FavouriteRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          unselectedFontSize: 14,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(
                Icons.manage_search_outlined,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Favourite',
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.person_outline,
                size: 30,
              ),
            ),
          ],
        );
      },
    );
  }
}
