import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/color.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectItem = ref.watch(productProvider).selectedProducts;
    var isLoading = ref.watch(productProvider).isLoading;
    final isFavorite = ref
        .watch(productProvider)
        .favoriteIds
        .contains(selectItem.first.id.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: selectItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: context.dynamicHeight(0.3),
                    alignment: Alignment.center,
                    child: Image.network(
                      selectItem[index].imageUrl ?? 'not image',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.04),
                  ),
                  CustomTextWidget(
                    text: selectItem[index].name ?? '',
                    fontsize: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSubTextWidget(
                          text: selectItem[index].weight ?? 'not weight'),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(productProvider)
                              .setFavorite(selectItem[index]);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : Colors.grey,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => ref
                                  .watch(productProvider)
                                  .counterDecrement(selectItem[index]),
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
                                text: selectItem[index].quantity.toString(),
                                fontsize: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () => ref
                                  .watch(productProvider)
                                  .counterIncrement(selectItem[index]),
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                                color: ColorConst.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        CustomTextWidget(
                          text:
                              '\$${ref.watch(productProvider).total.toString()}',
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
                    text: selectItem[index].description ?? '',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomElevatedButton(
                      text: 'Add To Basket',
                      onPressed: () {
                        if (isLoading == false) {
                          ref.read(productProvider).addBasket();
                          Fluttertoast.showToast(
                            msg: "✔️ Ürün sepete eklendi!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 0,
                            backgroundColor: ColorConst.primaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
