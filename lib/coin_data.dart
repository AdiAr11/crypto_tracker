import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// String apiURL = "https://rest.coinapi.io/v1/exchangerate";
// String apiKEY = "?apikey=8121EAD2-A0AE-4F68-8405-4B24673B0EDF";

Future fetchData(String cryptoCurrency,String selectedCurrency) async {

  String url = "https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/"
      "$selectedCurrency/?apikey=8121EAD2-A0AE-4F68-8405-4B24673B0EDF";

  final response = await http
      .get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var decodedData = jsonDecode(response.body);
    var latestPrice = decodedData["rate"];
    return latestPrice;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to fetch data');
  }
}