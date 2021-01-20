import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart';

class StockSuggestion {
  final String symbol;
  final String name;

  StockSuggestion(this.symbol, this.name);
}

class StockApiProvider {
  final client = Client();
  static final String yourKey = "TNZYNNAH9R89B4D5";

  Future<List<StockSuggestion>> fetchSuggestions(String input) async {
    final request =
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$input&apikey=TNZYNNAH9R89B4D5';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['bestMatches'].length == 0) {
        return [];
      }
      //if(result['bestMatches'])
      return result['predictions']
          .map<StockSuggestion>(
              (p) => StockSuggestion(p['1. symbol'], p['2. name']))
          .toList();
    }
  }
}
