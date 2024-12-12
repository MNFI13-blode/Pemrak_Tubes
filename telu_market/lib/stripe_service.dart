import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      "sk_test_51QUWvNIV40He6NZpjghp2KyBHAmtLZIg3gBpWUF0HfFbrIveP4T1Hrt6hgaQSXhgIvzJEMqXWKXxUHmceGvibzgV0047tX9bgW";

  static Map<String, String> headers = {
    "Authorization": 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    Stripe.publishableKey =
        'pk_test_51QUWvNIV40He6NZp8VeRdOjdbdTxuvHdCldXSOV6eQgHfJSk8mSaHBjqptX47bb67k1VGWMJDxIg4wgHguQ2OBI600Re6q8Oyw';
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception("gagal membuat");
    }
  }

  static Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      final paymentIntent = await createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: "Telu Merchant",
            style: ThemeMode.system),
      );
    } catch (e) {
      throw Exception("gagal inisial");
    }
  }

  static Future<void> presetPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception("gagal menghadirkan");
    }
  }
}
