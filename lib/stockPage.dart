import 'package:flutter/material.dart';
import 'package:stocksearch/NewsPage.dart';
import 'package:stocksearch/helper/stock_model.dart';

import 'helper/stockInfoClass.dart';

class StockPage extends StatefulWidget {
  final String stockName;
  StockPage({this.stockName});

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List<StockModel> stocks = new List<StockModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStockInfo();
  }

  getStockInfo() async {
    StockInfoClass newStock = StockInfoClass();
    await newStock.getStock(widget.stockName);
    stocks = newStock.stockInfo;
    // var test = stocks[0];
    // print(stocks[0].price);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Finacial"),
              Text(
                "Art",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          actions: <Widget>[
            Opacity(
              //to make title when article pressed in the center
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.category)),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: SizedBox(
                  width: 300,
                  height: 250,
                  child: Container(
                      //margin: EdgeInsets.only(top: 100),

                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple[800], width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            'Stock Name: ${stocks[0].symbol}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontFamily: "Caveat",
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Stock Price: ${stocks[0].price}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontFamily: "Caveat",
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 50),
                          RaisedButton(
                            child: Text(
                              'Get News',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                            stockName: stocks[0].symbol,
                                          )));
                            },
                          )
                        ],
                      )),
                ),
              ));
  }
}
