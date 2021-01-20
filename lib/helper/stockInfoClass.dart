import 'dart:convert';

import 'package:stocksearch/helper/stock_model.dart';
import 'package:http/http.dart' as http;

class StockInfoClass {
  List<StockModel> stockInfo = [];

  Future<void> getStock(String stockName) async {
    String url =
        "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$stockName&apikey=TNZYNNAH9R89B4D5";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var jsonStock = jsonData["Global Quote"];
    StockModel stockModel = StockModel(
        price: jsonStock['05. price'], symbol: jsonStock["01. symbol"]);
    stockInfo.add(stockModel);
  }
}
