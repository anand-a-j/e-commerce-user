import 'dart:convert';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/login/screen/sign_in_screen.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<List<Order>> fetchOrderDetails({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/current-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                orderList.add(
                  Order.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
            });
      }
    } catch (e) {
      debugPrint("get product-category error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routeName, (route) => false);
        showSnackBar(context, "Logout Successfully", isError: false);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
  }
}
