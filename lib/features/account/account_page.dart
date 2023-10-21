import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Container(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://randomuser.me/api/portraits/men/84.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 40, left: 15),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                fontsize: 20,
                fontWeight: FontWeight.bold,
                text: 'Account',
              ),
              CustomSubTextWidget(
                text: 'ersin@testgmail.com',
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Divider(),
            _AccountListItem(
              onTap: () {
                ref.read(firestoreProvider.notifier).getOrders().then(
                      (value) => context.router.push(OrdersRoute()),
                    );
              },
              title: 'Orders',
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
            const Divider(),
            _AccountListItem(
              onTap: () {},
              title: 'My Details',
              icon: const Icon(Icons.medical_information_outlined),
            ),
            const Divider(),
            _AccountListItem(
              onTap: () {},
              title: 'Address',
              icon: const Icon(Icons.location_on_outlined),
            ),
            const Divider(),
            _AccountListItem(
              onTap: () {},
              title: 'Notifecations ',
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            SizedBox(
              height: context.dynamicHeight(0.2),
            ),
            SizedBox(
              child: TextButton.icon(
                onPressed: () {
                  ref.read(userNotifierProvider.notifier).signOut().then(
                        (value) => context.router.push(LogInRoute()),
                      );
                },
                style: TextButton.styleFrom(),
                icon: const Icon(Icons.logout, color: ColorConst.primaryColor),
                label: const Text(
                  'Log out',
                  style: TextStyle(color: ColorConst.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AccountListItem extends StatelessWidget {
  const _AccountListItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final Widget icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      iconColor: Colors.black,
      title: CustomTextWidget(
        text: title,
        fontsize: 18,
      ),
      leading: icon,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
