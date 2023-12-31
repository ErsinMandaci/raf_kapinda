import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/card/custom_card_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class CategoryFilterPage extends ConsumerWidget {
  const CategoryFilterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtCategory = ref.watch(productProvider).filteredFavoriteList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const CustomTextWidget(text: 'Deneme', fontsize: 24),
      ),
      body: GridView.builder(
        padding: context.paddingNormal,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          childAspectRatio: 0.7,
        ),
        itemCount: filtCategory?.length ?? 0,
        itemBuilder: (context, index) {
          if (filtCategory == null || filtCategory.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorConst.primaryColor,
              ),
            );
          }
          final filtProduct = filtCategory[index];

          return CustomCard(
            imageUrl: filtProduct.imageUrl!,
            name: filtProduct.name,
            weigth: filtProduct.weight,
            price: '\$${filtProduct.price}',
            products: filtProduct,
          );
        },
      ),
    );
  }
}
