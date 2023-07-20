import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/features/account/account_page.dart';
import 'package:groceries_app/features/card/cart_page.dart';
import 'package:groceries_app/features/explore/explore_page.dart';
import 'package:groceries_app/features/favourite/favourite.dart';
import 'package:groceries_app/features/home/home_page.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

class BottomPageBuilder extends ConsumerStatefulWidget {
  const BottomPageBuilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<BottomPageBuilder> {
  int currentIndex = 0;
  late final PageController _bottomPageController;

  @override
  void initState() {
    super.initState();
    _bottomPageController = PageController();
  }

  @override
  void dispose() {
    _bottomPageController.dispose();
    super.dispose();
  }

  final pages = [
    const HomePage(),
    ExplorePage(),
    const CartPage(),
    const FavouritePage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final basketLength = ref.watch(productProvider).basketProducts.length;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomPageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: SizedBox(
        height: context.dynamicHeight(0.1),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: ColorConst.primaryColor,
          unselectedItemColor: Colors.black54,
          unselectedFontSize: 14,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
            _bottomPageController.jumpToPage(value);
          },
          items: [
            const BottomNavigationBarItem(
              label: 'Shope',
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              ),
            ),
            const BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(
                Icons.manage_search_outlined,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  ),
                  if (basketLength > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          basketLength.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
            const BottomNavigationBarItem(
              label: 'Favourite',
              icon: Icon(
                Icons.favorite_outline,
                size: 30,
              ),
            ),
            const BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.manage_accounts_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
