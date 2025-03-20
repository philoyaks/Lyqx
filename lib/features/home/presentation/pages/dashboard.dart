// Dashboard Screen with Bottom Navigation
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/core/constants/app_enums.dart';
import 'package:lyqx/features/cart/presentation/pages/cart_home_page.dart';
import 'package:lyqx/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:lyqx/features/home/presentation/pages/home_page.dart';
import 'package:lyqx/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:lyqx/features/home/presentation/widgets/checkout_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardTab>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: state.index,
                children: [
                  HomeScreen(),
                  WishlistScreen(),
                  CartScreen(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              selectedItemColor: Colors.black,
              onTap: (index) {
                context
                    .read<DashboardBloc>()
                    .add(ChangeTab(DashboardTab.values[index]));
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.homeIcon,
                      colorFilter: state == DashboardTab.home
                          ? null
                          : ColorFilter.mode(
                              Color(0xFFCBCBD4), BlendMode.srcIn),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.heart,
                      colorFilter: state != DashboardTab.wishlist
                          ? null
                          : ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.cartIcon,
                      colorFilter: state != DashboardTab.cart
                          ? null
                          : ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                    label: ''),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                state == DashboardTab.cart ? CheckoutItem() : null);
      },
    );
  }
}
