import 'package:flutter/material.dart';
import 'package:groceries_app/core/widgets/card/custom_button_card.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/model/products.dart';
import 'package:kartal/kartal.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.imageUrl,
    required this.name,
    required this.weigth,
    required this.price,
    required this.products,
    super.key,
  });
  final String? imageUrl;
  final String? name;
  final String? weigth;
  final String? price;
  final Products products;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: context.dynamicWidth(0.4),
        height: context.dynamicHeight(0.25),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  imageUrl ?? 'not found image',
                  width: context.dynamicWidth(0.35),
                  height: context.dynamicHeight(0.15),
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              CustomTextWidget(
                text: name ?? 'not found name',
                fontsize: 16,
              ),
              CustomSubTextWidget(
                text: weigth ?? 'not found description',
                fontSize: 14,
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: price.toString(),
                    fontsize: 16,
                  ),
                  CustomAddButton(
                    products: products,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
