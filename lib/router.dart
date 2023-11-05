import 'package:e_commerce_app/features/address/screen/address_screen.dart';
import 'package:e_commerce_app/features/admin/screen/add_product_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/features/checkout/screen/checkout_screen.dart';
import 'package:e_commerce_app/features/checkout/screen/order_success_screen.dart';
import 'package:e_commerce_app/features/home/screens/category_deals_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/features/order_details/screen/order_details_screen.dart';
import 'package:e_commerce_app/features/order_details/screen/orders_screen.dart';
import 'package:e_commerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/search/screens/search_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomNavBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CartScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CartScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(category: category));
    case SearchScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SearchScreen());
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      var total = routeSettings.arguments as double;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(totalAmount: total));
    case CheckoutScreen.routeName:
      AddressArguments arguments = routeSettings.arguments as AddressArguments;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CheckoutScreen(
                totalAmount: arguments.total,
                address: arguments.address,
              )
              );
        case OrdersScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const OrdersScreen());
    case OrderSuccessScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const OrderSuccessScreen());
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Error!!!"),
          ),
        ),
      );
  }
}

class AddressArguments {
  final double total;
  final String address;

  AddressArguments(this.total, this.address);
}
