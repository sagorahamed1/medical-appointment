
import 'dart:convert';
import 'package:doctor_appointment/controllers/user/user_patient_details_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../routes/app_routes.dart';
import '../utils/constants.dart';


class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  PaymentController() {
    Stripe.publishableKey = Constants.publishAbleKey;
  }

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
      if (kDebugMode) {
        print("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment intent: $e');
      }
      throw e;
    }
  }

  Future<void> makePayment({Map<String, dynamic>? data, String? amount }) async {
    try {
      paymentIntentData = await createPaymentIntent("$amount", "USD");
      if (paymentIntentData != null) {
        String clientSecret = paymentIntentData!['client_secret'];

        if (kDebugMode) {
          print("Client Secret: $clientSecret");
        }

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
                name: 'Raenir',
                email: 'edelevatedaily@gmail.com'),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
            merchantDisplayName: 'Raenir',
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.dark,
          ),
        );

        displayPaymentSheet(data: data ?? {});
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e\nStack trace: $s');
      }
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':  calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${Constants.secretKey}', // Use sk_test_... key here
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (kDebugMode) {
        print("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e, s) {
      if (kDebugMode) {
        print("Error creating payment intent: $e");
        print("Error creating payment intent: $s");
      }
      return null;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<void> displayPaymentSheet({required Map<String, dynamic> data}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      retrieveTxnId(paymentIntent: paymentIntentData!['id'], paymentData: data); ///subscription id
      if (kDebugMode) {
        print('Payment intent: $paymentIntentData');
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Paid successfully")));
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        print("Error displaying payment sheet: $e");
      }
    }
  }

  Future<void> retrieveTxnId({required String paymentIntent, required Map<String, dynamic> paymentData}) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
        headers: {
          "Authorization": "Bearer ${Constants.secretKey}", // Use sk_test_... key here
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          print("Transaction Id: ${data['data'][0]['balance_transaction']}");
        }
        var transactionId = data['data'][0]['balance_transaction'];

        final UserPatientDetailsController _patientDetailsController = Get.put(UserPatientDetailsController());
        print("${paymentData["age"]}");

        _patientDetailsController.patienDetailsAdd(
            fullName: "${paymentData["fullName"]}",
            age: "${paymentData["age"]}",
            gender: "${paymentData["gender"]}",
            description: "${paymentData["description"]}",
            doctorId: "${paymentData["doctorId"]}",
            price: "${paymentData["price"]}",
            packName: "${paymentData["packName"]}",
            timeSlot: "${paymentData["timeSlot"]}",
            date: "${paymentData["date"]}"
        );


      }else{
        print("******************************************************************************************************");
      }
    } catch (e) {
      Get.toNamed(AppRoutes.failedPayment);
      throw Exception("Error retrieving transaction ID: $e");
    }
  }
}