import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:groceries_app/model/products.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketProducts = ref.watch(productProvider).basketList;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.dynamicHeight(0.1),
        title: const Center(
          child: CustomTextWidget(text: 'My Cart'),
        ),
      ),
      body: basketProducts.isNullOrEmpty
          ? const Center(
              child: CustomSubTextWidget(
                text: 'No Product ',
                fontWeight: FontWeight.bold,
              ),
            )
          : SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: basketProducts?.length ?? 0,
                      itemBuilder: (context, index) {
                        final basketIndex = basketProducts?[index];
                        if (basketIndex == null) {
                          return const Center(
                            child: CustomSubTextWidget(
                              text: 'No Product ',
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return ListTile(
                          visualDensity: const VisualDensity(vertical: 4),
                          leading: Image.network(
                            basketIndex.imageUrl!,
                            width: context.dynamicWidth(0.2),
                            height: context.dynamicHeight(0.1),
                            fit: BoxFit.fill,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    fontsize: 16,
                                    text: basketIndex.name!,
                                  ),
                                  _CustomAlertDialog(basketIndex: basketIndex)
                                ],
                              ),
                              CustomSubTextWidget(
                                text: basketIndex.weight!,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        ref.watch(productProvider.notifier).decrementProductQuantity(basketIndex),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  CustomTextWidget(
                                    fontsize: 18,
                                    text: basketIndex.quantity.toString(),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        ref.watch(productProvider.notifier).incrementProductQuantity(basketIndex),
                                    icon: const Icon(
                                      Icons.add,
                                      color: ColorConst.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextWidget(
                                fontWeight: FontWeight.w600,
                                fontsize: 16,
                                text: '\$${ref.watch(productProvider).totalBasketPrice}',
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: context.dynamicWidth(0.8),
                      height: context.dynamicHeight(0.07),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet<Widget>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const ListTile(
                                          contentPadding: EdgeInsets.all(30),
                                          leading: CustomSubTextWidget(
                                            text: 'Delivery',
                                          ),
                                          trailing: SizedBox(
                                            width: 200,
                                            height: 100,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('Select Method'),
                                                Icon(Icons.arrow_forward_ios),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        const ListTile(
                                          contentPadding: EdgeInsets.all(30),
                                          leading: CustomSubTextWidget(
                                            text: 'Payment',
                                          ),
                                          trailing: Icon(Icons.credit_card),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        ListTile(
                                          contentPadding: const EdgeInsets.all(30),
                                          leading: const CustomSubTextWidget(
                                            text: 'Total Cost',
                                          ),
                                          trailing: CustomTextWidget(
                                            fontsize: 18,
                                            text: '\$${ref.read(productProvider).productQuantity}',
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        Center(
                                          child: CustomElevatedButton(
                                            onPressed: () {
                                              ref
                                                  .read(firestoreProvider.notifier)
                                                  .pushBasketDataToFirestore(
                                                    // null gelebilir mi bak ?
                                                    basketProducts!,
                                                  )
                                                  .then(
                                                    (value) => basketProducts.clear(),
                                                  )
                                                  .then(
                                                    (value) => Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute<Widget>(
                                                        builder: (context) => const BottomPageBuilder(),
                                                      ),
                                                      (route) => false,
                                                    ),
                                                  );

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: ColorConst.primaryColor,
                                                  content: Text(
                                                    'Siparişiniz alındı.',
                                                  ),
                                                ),
                                              );
                                            },
                                            text: 'Place Order',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Go To Checkout'),
                            Container(
                              alignment: Alignment.center,
                              color: const Color(0xff489E67),
                              width: 50,
                              height: 30,
                              child: Text(
                                '\$${ref.watch(productProvider).totalBasketPrice}',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _CustomAlertDialog extends ConsumerWidget {
  const _CustomAlertDialog({
    required this.basketIndex,
  });

  final Products basketIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        showDialog<Widget>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ColorConst.primaryColor,
              contentTextStyle: const TextStyle(
                fontSize: 20,
              ),
              content: const Text('Are you sure you want to delete this product?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ColorConst.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(productProvider.notifier).removeProductBasket(basketIndex);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: ColorConst.primaryColor,
                        content: Text('Ürün başarıyla silindi.'),
                      ),
                    );
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ColorConst.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.close),
    );
  }
}
