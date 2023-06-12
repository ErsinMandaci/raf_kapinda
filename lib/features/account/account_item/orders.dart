import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrders = ref.watch(firestoreProvider).orderList;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: userOrders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                  leading:
                      Image.network(userOrders[index].imageUrl ?? 'deneme'),
                  title: CustomTextWidget(
                      text: userOrders[index].name ?? 'deneme'),
                  subtitle: Text(
                    userOrders[index].price.toString(),
                  ),
                  trailing: CustomTextWidget(
                    text: (userOrders[index].price! * userOrders[index].quantity!.toDouble()).toString(),
                  )),
            ),
          );
        },
      ),
    );
  }
}
