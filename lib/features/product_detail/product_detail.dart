import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
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
              Container(
                height: context.dynamicHeight(0.3),
                alignment: Alignment.center,
                child: Image.network(
                  selectItem.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              CustomTextWidget(
                text: selectItem.name!,
                fontsize: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubTextWidget(
                    text: selectItem.weight!,
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(productProvider.notifier).changeFavoriteCard(selectItem);
                      print(ref.watch(productProvider).isFavorite);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ref.watch(productProvider).isFavorite  ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
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
                            text: "${ref.watch(productProvider).productQuantity}",
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
                      text: '\$${ref.watch(productProvider).totalBasketPrice.toStringAsFixed(2)}',
                      fontsize: 24,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(),
              Row(
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
              ),
              CustomSubTextWidget(
                text: selectItem.description!,
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
