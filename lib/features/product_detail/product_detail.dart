import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:groceries_app/model/products.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectItem = ref.watch(productProvider).selectedProduct;

    if (selectItem == null) {
      return Scaffold(
        body: Center(
          child: Text('No product selected'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SelectItemImage(selectItem: selectItem),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              CustomTextWidget(
                text: selectItem.name!,
                fontsize: 24,
              ),
              _SelectItemWeight(selectItem: selectItem),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(productProvider.notifier).decrementProductQuantity(selectItem);
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: CustomTextWidget(
                            text: "${ref.watch(productProvider.notifier).getProductQuantity(selectItem.id.toString())}",
                            fontsize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(productProvider.notifier).incrementProductQuantity(selectItem);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: ColorConst.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomTextWidget(
                      text: '\$${ref.watch(productProvider).productTotalPrice.toStringAsFixed(2)}',
                      fontsize: 24,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(),
              _ProductDescription(),
              CustomSubTextWidget(
                text: selectItem.description!,
              ),
              const SizedBox(
                height: 40,
              ),
              _AddToastMessage(selectItem: selectItem),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddToastMessage extends ConsumerWidget {
  const _AddToastMessage({
    required this.selectItem,
  });

  final Products selectItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      child: CustomElevatedButton(
        text: 'Add To Basket',
        onPressed: () {
          ref.read(productProvider.notifier).addProductBasket(selectItem);
          Fluttertoast.showToast(
            msg: '✔️ Ürün sepete eklendi!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 0,
            backgroundColor: ColorConst.primaryColor,
            textColor: Colors.white,
            fontSize: 16,
          );
        },
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomTextWidget(
          fontWeight: FontWeight.w600,
          text: 'Product Description',
          fontsize: 16,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
        ),
      ],
    );
  }
}

class _SelectItemWeight extends ConsumerWidget {
  const _SelectItemWeight({
    required this.selectItem,
  });

  final Products selectItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSubTextWidget(
          text: selectItem.weight ?? "",
        ),
        IconButton(
          onPressed: () {
            ref.read(productProvider.notifier).changeFavoriteCard(selectItem);
          },
          icon: Icon(
            Icons.favorite,
            color: ref.watch(productProvider).isFavorite ? Colors.red : Colors.grey,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _SelectItemImage extends StatelessWidget {
  const _SelectItemImage({
    required this.selectItem,
  });

  final Products selectItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.3),
      alignment: Alignment.center,
      child: Image.network(
        selectItem.imageUrl ?? 'not found image',
        fit: BoxFit.cover,
      ),
    );
  }
}
