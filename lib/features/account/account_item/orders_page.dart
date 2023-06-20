import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrders = ref.read(firestoreProvider).orderList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(text: 'Orders'),
      ),
      body: ListView.builder(
        itemCount: userOrders.length,
        itemBuilder: (context, index) {
          var userOrdersIndex = userOrders[index];

          return Card(
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                      fontsize: 12, text: ' ${userOrdersIndex.orderNumber}'),
                ),
                CustomTextWidget(
                    fontsize: 12,
                    text: 'Order Date: ${userOrdersIndex.formattedCreatedAt}'),
                Column(
                  children: userOrdersIndex.products!.map((product) {
                    return ListTile(
                      leading: Image.network(
                        product.imageUrl ?? '',
                        fit: BoxFit.contain,
                        width: context.dynamicHeight(0.05),
                        height: 100,
                      ),
                      title: Text(product.name ?? ''),
                      subtitle: Text('Piece Price: ${product.price}'),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Piece: ${product.quantity}'),
                          Text(
                              'Total \$${(product.price ?? 0 * product.quantity!).roundToDouble()}'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
