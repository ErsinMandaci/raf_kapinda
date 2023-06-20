import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/provider/riverpod_management.dart';
import '../../../model/products.dart';

import '../../constants/color.dart';

class CustomAddButton extends ConsumerWidget {
  final Products products;
  const CustomAddButton({super.key, required this.products});

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
          ref
              .read(productProvider)
              .selectedItem(products)
              .then((value) => Navigator.pushNamed(context, 'detail'));
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
