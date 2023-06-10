import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favProduct = ref.watch(productProvider).getFavoriteProducts();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Favourite',
          fontsize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: favProduct.isEmpty
          ? const Center(
              child: CustomSubTextWidget(
                text: 'No Favourite Product ',
                fontWeight: FontWeight.bold,
              ),
            )
          : ListView.builder(
              itemCount: favProduct.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      ref
                          .read(productProvider)
                          .selectedItem(favProduct[index])
                          .then((value) =>
                              Navigator.pushNamed(context, 'detail'));
                    },
                    leading: Image.network(favProduct[index].imageUrl ?? ''),
                    title: CustomTextWidget(
                      text: favProduct[index].name ?? '',
                      fontsize: 18,
                    ),
                    subtitle: CustomSubTextWidget(
                      text: favProduct[index].weight ?? '',
                      fontSize: 14,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextWidget(
                          text: '\$${favProduct[index].price}',
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
