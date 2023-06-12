import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/card/custom_card_widget.dart';
import 'package:groceries_app/core/widgets/carousel_builder.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/riverpod_management.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future(() => ref.read(productProvider).fetchAndLoad());
  }

  @override
  Widget build(BuildContext context) {
    final productWatch = ref.watch(productProvider).products;
    //final isLoading = ref.watch(productProvider).isLoading;
    //final dataLoading = ref.watch(productProvider).dataloading;

    return Scaffold(
      appBar: AppBar(),
      body: productWatch.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: context.paddingLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageBuilder(),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(text: 'Exclusive Offer', fontsize: 24),
                        CustomSubTextWidget(
                          text: 'See all',
                          color: ColorConst.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.3),
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productWatch.length,
                        itemBuilder: (context, index) {
                          if (productWatch[index].imageUrl == null) {
                            return Shimmer.fromColors(
                              baseColor: const Color.fromARGB(255, 83, 82, 82),
                              highlightColor:
                                  const Color.fromARGB(255, 92, 92, 92),
                              child: Container(
                                width: double.infinity,
                                height: context.dynamicHeight(0.3),
                                color: Colors.black,
                              ),
                            );
                          } else {
                            return CustomCard(
                              imageUrl: productWatch[index].imageUrl,
                              name: productWatch[index].name,
                              weigth: productWatch[index].weight,
                              price: '\$${productWatch[index].price}',
                              products: productWatch[index],
                            );
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(text: 'Best Selling', fontsize: 24),
                          CustomSubTextWidget(
                            text: 'See all',
                            color: ColorConst.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.3),
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productWatch.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            imageUrl: productWatch[index].imageUrl,
                            name: productWatch[index].name,
                            weigth: productWatch[index].weight,
                            price: '\$${productWatch[index].price}',
                            products: productWatch[index],
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

// class _CustomTextField extends StatelessWidget {
//   const _CustomTextField();

//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//         ),
//         hintText: 'Search store',
//         hintStyle: TextStyle(
//           fontSize: 14,
//           color: ColorConst.subTextColor,
//         ),
//         prefixIcon: Icon(
//           Icons.search,
//           size: 24,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
