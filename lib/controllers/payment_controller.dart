
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
        debugPrint("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error fetching payment intent: $e');
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
          debugPrint("Client Secret: $clientSecret");
        }

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
                name: 'Vanture',
                email: 'info@medroofurgentcare.com'),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
            merchantDisplayName: 'Vanture',
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.dark,
          ),
        );

        displayPaymentSheet(data: data ?? {});
      }
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint('Exception: $e\nStack trace: $s');
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
        debugPrint("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint("Error creating payment intent: $e");
        debugPrint("Error creating payment intent: $s");
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
        debugPrint('Payment intent: $paymentIntentData');
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Paid successfully")));
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error displaying payment sheet: $e");
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
          debugPrint("Transaction Id: ${data['data'][0]['balance_transaction']}");
        }
        var transactionId = data['data'][0]['balance_transaction'];

        final UserPatientDetailsController _patientDetailsController = Get.put(UserPatientDetailsController());
        debugPrint("${paymentData["age"]}");

        _patientDetailsController.patienDetailsAdd(
            fullName: "${paymentData["fullName"]}",
            age: "${paymentData["age"]}",
            gender: "${paymentData["gender"]}",
            description: "${paymentData["description"]}",
            doctorId: "${paymentData["doctorId"]}",
            price: "${paymentData["price"]}",
            packName: "${paymentData["packName"]}",
            timeSlot: "${paymentData["timeSlot"]}",
            date: "${paymentData["date"]}",
           paymentType: "stripe"
        );


      }else{
        debugPrint("******************************************************************************************************");
      }
    } catch (e) {
      Get.toNamed(AppRoutes.failedPayment);
      throw Exception("Error retrieving transaction ID: $e");
    }
  }
}