import 'package:http_auth/http_auth.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Paypal {
  String domain = 'https://api.sandbox.paypal.com';
  String clientId = '';
  String secret = '';

  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "0";
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> _creatPaymentMethod(
      transaction, accessToken) async {
    try {
      var response = await http.post(Uri.parse('$domain/v1/payments/payment'),
          headers: {
            "content_type": "application/json",
            "Authorization": "Bearer" + accessToken
          });
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];
          String executreURl = '';
          String approvalUrl = '';
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item != null) {
            executreURl = item["href"];
          }
          return {"executeUrl": executreURl, "approvalUrl": approvalUrl};
        }
        throw Exception("0");
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content_type": "application/json",
            "Authorization": "Bearer" + accessToken
          });
          final body=convert.jsonDecode(response.body);
          if(response.statusCode==200){
            return body["id"];
          }
          return "0";
    } catch (e) {
      rethrow;
    }
  }
}
