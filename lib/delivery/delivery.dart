import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:procurex/utils/decimalTextInputFormatter.dart';
import 'package:procurex/utils/drawer.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  List<String> _items = ["gal", "wali", "Cimenti"];
  DateTime selectedDate = DateTime.now();
  final _dateText = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateText.text = picked.day.toString() +
            '-' +
            picked.month.toString() +
            '-' +
            picked.year.toString();
      });
  }

  _modal(context, items) {
    String dropdownValue, quantity, orderNo;
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Delivery'),
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Invoice No'),
                        onChanged: (value) => orderNo = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the date of delivery';
                          }
                          return null;
                        },
                      ),
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the date of delivery';
                          }
                          return null;
                        },
                        controller: _dateText,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Date of Delivery',
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            size: 26,
                            color: Colors.blue[900],
                          ),
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate(context);
                        },
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
                            quantity = value;
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
                              print(quantity);
                              print(_dateText.text);
                              print(orderNo);
                              // Navigator.of(context).pop();
                            }
                          },
                        ),
                      )
                    ],
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _modal(context, _items),
        tooltip: 'Dispatch Items',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Delivery Log'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            DeliveryItem(
              order: '#00001',
              item: 'Weli',
              date: '15-10-2020',
              quantity: '5',
              price: '20',
              total: '100',
              id: '1',
            ),
            DeliveryItem(
              order: '#00002',
              item: 'Cement',
              date: '16-10-2020',
              quantity: '5',
              price: '20',
              total: '100',
              id: '1',
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryItem extends StatefulWidget {
  const DeliveryItem({
    Key key,
    this.date,
    this.id,
    this.item,
    this.order,
    this.price,
    this.quantity,
    this.total,
  }) : super(key: key);

  final String order, item, date, quantity, price, total, id;

  @override
  _DeliveryItemState createState() => _DeliveryItemState();
}

class _DeliveryItemState extends State<DeliveryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      child: ExpansionCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.order),
            Text(widget.item),
            Text(widget.date),
          ],
        ),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.quantity,
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
                        widget.price,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Unit Price',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.total,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Total',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    onPressed: () => print(widget.id),
                    child: Text(
                      'Return',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => print(widget.id),
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
