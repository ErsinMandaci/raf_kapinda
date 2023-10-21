import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/card/custom_card_widget.dart';
import 'package:groceries_app/core/widgets/carousel_builder.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:groceries_app/model/products.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
final class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future(() => ref.read(productProvider.notifier).allProduct());
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productProvider).productList;

    if (productList.isNullOrEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageBuilderPage(),
              const SizedBox(height: 20),
              _ExclusiveWidget(),
              _ExculitiveProductListView(productList: productList),
              _BestSellingWidget(),
              _BestSellListView(productList: productList),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExclusiveWidget extends StatelessWidget {
  const _ExclusiveWidget();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(text: 'Exclusive Offer', fontsize: 24),
        CustomSubTextWidget(
          text: 'See all',
          color: ColorConst.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _ExculitiveProductListView extends StatelessWidget {
  const _ExculitiveProductListView({
    required this.productList,
  });

  final List<Products>? productList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.3),
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productList?.length,
        itemBuilder: (context, index) {
          if (productList?[index].imageUrl == null) {
            return Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 83, 82, 82),
              highlightColor: const Color.fromARGB(255, 92, 92, 92),
              child: Container(
                width: double.infinity,
                height: context.dynamicHeight(0.3),
                color: Colors.black,
              ),
            );
          } else {
            return CustomCard(
              imageUrl: productList?[index].imageUrl,
              name: productList?[index].name,
              weigth: productList?[index].weight,
              price: '\$${productList?[index].price}',
              products: productList?[index],
            );
          }
        },
      ),
    );
  }
}

class _BestSellListView extends StatelessWidget {
  const _BestSellListView({
    required this.productList,
  });

  final List<Products>? productList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.3),
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productList?.length,
        itemBuilder: (context, index) {
          return CustomCard(
            imageUrl: productList?[index].imageUrl,
            name: productList?[index].name,
            weigth: productList?[index].weight,
            price: '\$${productList?[index].price}',
            products: productList?[index],
          );
        },
      ),
    );
  }
}

class _BestSellingWidget extends StatelessWidget {
  const _BestSellingWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
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
    );
  }
}
