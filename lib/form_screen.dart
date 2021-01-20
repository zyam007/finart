import 'package:flutter/material.dart';
import 'package:stocksearch/stockPage.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  String _stock;
  String _stockShort;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildStockName() {
    return TextFormField(
      controller: myController,
      onTap: () async {
        // placeholder for our places search later
      },
      decoration: InputDecoration(labelText: 'Stock Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Stock name is required';
        }
      },
      onSaved: (String value) {
        _stock = value;
      },
    );
  }

  // Widget _buildStockShort() {
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FinNews'),
      ),
      body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStockName(),
                // _buildStockShort(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Get Stock',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    //to save user value into state, so can use to get stock
                    _formKey.currentState.save();
                    //now _stock has user input
                    print(_stock);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StockPage(stockName: _stock)));
                  },
                )
              ],
            ),
          )),
    );
  }
}

//new page to display stock price from user input
// class StockPage extends StatelessWidget {
//   final String stockName;

//   StockPage(this.stockName);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Stock Price'),
//         ),
//         body: Container(
//           child: Text(stockName),
//         ));
//   }
// }
