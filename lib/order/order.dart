import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procurex/utils/decimalTextInputFormatter.dart';
import 'package:procurex/utils/drawer.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            OrderItem(
              date: '16-10-2020',
              id: '1',
              item: 'Cement',
              quantity: '10',
              status: 'Pending',
              supplier: 'Mahinda Hardware',
            ),
            OrderItem(
              date: '16-10-2020',
              id: '1',
              item: 'Cement',
              quantity: '20',
              status: 'Cancelled',
              supplier: 'Mahinda Hardware',
            ),
            OrderItem(
              date: '16-10-2020',
              id: '1',
              item: 'Cement',
              quantity: '15',
              status: 'Placed',
              supplier: 'Mahinda Hardware',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key key,
    this.date,
    this.id,
    this.item,
    this.quantity,
    this.status,
    this.supplier,
  }) : super(key: key);

  final String id, item, quantity, date, status, supplier;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final _dateText = TextEditingController();
  String quantity;

  @override
  initState() {
    super.initState();
    _dateText.text = widget.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd-MM-yyyy').parse(widget.date),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      child: ExpansionCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(widget.item),
                Text(
                  'Item',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(widget.quantity),
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(widget.date),
                Text(
                  'Date',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  widget.status,
                  style: TextStyle(
                      color: widget.status == 'Placed'
                          ? Colors.greenAccent[400]
                          : Colors.red,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Status',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        children: [
          Column(
            children: [
              Column(
                children: [
                  Text(
                    widget.supplier,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Supplier',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                            initialValue: widget.quantity,
                                            decoration: InputDecoration(
                                                labelText: 'Quantity'),
                                            inputFormatters: [
                                              DecimalTextInputFormatter()
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
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
                                            padding: EdgeInsets.only(top: 15),
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter the date of delivery';
                                                }
                                                return null;
                                              },
                                              controller: _dateText,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 18),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelText: 'Expected Date',
                                                suffixIcon: Icon(
                                                    Icons.calendar_today,
                                                    size: 26,
                                                    color: Colors.yellow[500]),
                                              ),
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                _selectDate(context);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                              child: Text("Submit"),
                                              onPressed: () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  print(_dateText.text);
                                                  print(quantity);
                                                  Navigator.of(context).pop();
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
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ),
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          print(widget.id);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        )),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
