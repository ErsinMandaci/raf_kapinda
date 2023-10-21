import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:groceries_app/model/products.dart';

final class CustomAddButton extends ConsumerWidget {
  const CustomAddButton({required this.products, super.key});
  final Products products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConst.primaryColor,
      ),
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () {
          ref.read(productProvider.notifier).selectedItem(products);
          if (ref.watch(productProvider).selectedProduct != null)
          context.router.push(ProductDetailRoute());
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
