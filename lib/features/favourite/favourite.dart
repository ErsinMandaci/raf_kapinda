import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(productProvider).filteredFavoriteList;

    if (favoriteList.isNullOrEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Favourite',
          fontsize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteList!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                ref.read(productProvider.notifier).selectedItem(favoriteList[index]);
                if (ref.watch(productProvider).selectedProduct != null) context.router.push(const ProductDetailRoute());
              },
              leading: Image.network(favoriteList[index].imageUrl!),
              title: CustomTextWidget(
                text: favoriteList[index].name!,
                fontsize: 18,
              ),
              subtitle: CustomSubTextWidget(
                text: favoriteList[index].weight!,
                fontSize: 14,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextWidget(
                    text: '\$${favoriteList[index].price}',
                    fontsize: 18,
                  ),
                  const Icon(Icons.navigate_next_rounded, size: 30)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
