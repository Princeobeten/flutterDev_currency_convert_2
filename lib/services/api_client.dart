import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyURL = Uri.https('v6.exchangerate-api.com', '/v6/f864376c286e79b32a398779/latest/USD', );

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var rates = body["conversion_rates"];
      List<String> currencies = rates.keys.toList();
      print(currencies);
      return currencies;
    } else {
      throw Exception('\n\n\n\n Failed to connect to API \n\n\n\n');
    }
  }

  // getting exchange rate 
Future<double> getRate(String from, String to) async {
  final String apiKey = 'f864376c286e79b32a398779'; // Replace with your actual API key
  final Uri pairURL = Uri.https(
    'v6.exchangerate-api.com',
    '/v6/$apiKey/pair/$from/$to',
  );

  try {
    http.Response res = await http.get(pairURL);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      if (body['result'] == 'success') {
        return body['conversion_rate'] ?? 0.0;
      } else {
        print('Failed to get exchange rate: ${body["error-type"]}');
        return 0.0; // You can return a default value or handle the error accordingly
      }
    } else {
      print('Failed to get exchange rate: ${res.statusCode}');
      return 0.0; // You can return a default value or handle the error accordingly
    }
  } catch (e) {
    print('Error fetching exchange rate: $e');
    return 0.0; // You can return a default value or handle the error accordingly
  }
}



}
