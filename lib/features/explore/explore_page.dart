import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/card/custom_card_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:kartal/kartal.dart';

import '../provider/riverpod_management.dart';

class ExplorePage extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();
  ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(productProvider).categories;
    final search = ref.watch(productProvider).searchProducts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(text: 'Products'),
      ),
      body: Column(
        children: [
          _SearchTextField(searchController: _searchController),
          if (search.isNotEmpty)
            Expanded(
              child: GridView.builder(
                padding: context.paddingNormal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.7,
                ),
                itemCount: search.length,
                itemBuilder: (context, index) {
                  final seacrhIndex = search[index];
                  return CustomCard(
                      imageUrl: seacrhIndex.imageUrl,
                      name: seacrhIndex.name,
                      weigth: seacrhIndex.weight.toString(),
                      price: seacrhIndex.price.toString(),
                      products: seacrhIndex);
                },
              ),
            )
          else if (_searchController.text.isEmpty)
            Expanded(
              child: GridView.builder(
                padding: context.paddingNormal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.8,
                ),
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ref
                          .read(productProvider)
                          .onCategorySelected(category[index]);
                      Navigator.pushNamed(context, 'categoryFilter');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            category[index].categoryImage ?? '',
                            fit: BoxFit.fill,
                            width: 120,
                            height: 120,
                          ),
                          CustomTextWidget(
                              fontWeight: FontWeight.bold,
                              fontsize: 16,
                              text: category[index].name ?? '')
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: CustomTextWidget(
                  text: 'No result found',
                  fontsize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchTextField extends ConsumerStatefulWidget {
  final TextEditingController searchController;
  const _SearchTextField({required this.searchController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __SearchTextFieldState();
}

class __SearchTextFieldState extends ConsumerState<_SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      onChanged: (value) {
        ref.watch(productProvider).searchList(value);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: 'Search store',
        hintStyle: TextStyle(
          fontSize: 14,
          color: ColorConst.subTextColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
