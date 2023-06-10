import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/color.dart';
import '../explore/explore_page.dart';
import 'home_page.dart';

class NavigatorBottom extends StatefulWidget {
  const NavigatorBottom({super.key});

  @override
  State<NavigatorBottom> createState() => _NavigatorBottomState();
}

int currentIndex = 0;

final pages = [const HomePage(),  ExplorePage()];

class _NavigatorBottomState extends State<NavigatorBottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: context.dynamicHeight(0.1),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: ColorConst.primaryColor,
          unselectedItemColor: Colors.black,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Shope',
              icon: Icon(
                Icons.shopping_bag_outlined,
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
                Icons.favorite_outline,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.manage_accounts_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
