import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:procurex/utils/decimalTextInputFormatter.dart';
import 'package:procurex/utils/drawer.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  List<String> _items = ["gal", "wali", "Cimenti"];

  _modal(context, items) {
    String dropdownValue, qty;
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dispatch Item'),
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: dropdownValue,
                      hint: Text('Select item'),
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue),
                      validator: (value) =>
                          value == null ? 'Please select an item' : null,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Quantity'),
                      inputFormatters: [DecimalTextInputFormatter()],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        setState(() {
                          qty = value;
                        });
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print(dropdownValue);
                            print(qty);
                            // Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Stock'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _modal(context, _items),
        tooltip: 'Dispatch Items',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            StockItem(
              item: 'Gal',
              qty: '12',
              type: 'Cube',
              reorder: '2',
            ),
            StockItem(
              item: 'Wali',
              qty: '12',
              type: 'Cube',
              reorder: '2',
            ),
            StockItem(
              item: 'Cementi',
              qty: '12',
              type: 'Cube',
              reorder: '2',
            ),
          ],
        ),
      ),
    );
  }
}

class StockItem extends StatefulWidget {
  const StockItem({Key key, this.item, this.qty, this.reorder, this.type})
      : super(key: key);
  final String item, qty, type, reorder;
  @override
  _StockItemState createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      child: ExpansionCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.item,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    widget.qty,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Quantity',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.type,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Type',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.reorder,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Reorder-level',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
