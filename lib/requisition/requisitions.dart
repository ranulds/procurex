import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:procurex/requisition/newRequisition.dart';
import 'package:intl/intl.dart';

class Requisitions extends StatefulWidget {
  @override
  _RequisitionsState createState() => _RequisitionsState();
}

class _RequisitionsState extends State<Requisitions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requisitions'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => NewRequisition())),
        tooltip: 'New Requisition',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            RequisitionItem(
              item: 'Gal',
              qty: '10',
              status: 'Pending',
              date: '15-10-2020',
              comment: 'Urgent',
              id: '1',
            ),
            RequisitionItem(
              item: 'Gal',
              qty: '10',
              status: 'Placed',
              date: '14-10-2020',
              comment: 'Urgent',
              id: '2',
            ),
          ],
        ),
      ),
    );
  }
}

class RequisitionItem extends StatefulWidget {
  const RequisitionItem({
    Key key,
    this.comment,
    this.date,
    this.id,
    this.item,
    this.qty,
    this.status,
  }) : super(key: key);
  final String item, qty, status, date, comment, id;
  @override
  _RequisitionItemState createState() => _RequisitionItemState();
}

class _RequisitionItemState extends State<RequisitionItem> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final _dateText = TextEditingController();
  String qty, comment;

  @override
  initState() {
    super.initState();
    _dateText.text = widget.date;
    comment = widget.comment;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd-MM-yyyy').parse(widget.date),
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
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
          children: <Widget>[
            Text(
              widget.item,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              widget.qty,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              widget.status,
              style: TextStyle(
                color: widget.status == 'Placed'
                    ? Colors.greenAccent[400]
                    : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: [
              Text(
                widget.date,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.comment,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
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
                                        initialValue: widget.qty,
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
                                            qty = value;
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
                                            labelStyle: TextStyle(fontSize: 18),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelText: 'Expected Date',
                                            suffixIcon: Icon(
                                              Icons.calendar_today,
                                              size: 26,
                                              color: Colors.blue[900],
                                            ),
                                          ),
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            _selectDate(context);
                                          },
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: widget.comment,
                                        decoration: InputDecoration(
                                            labelText: 'Comments'),
                                        onChanged: (value) => comment = value,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          child: Text("Submit"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              print(_dateText.text);
                                              print(qty);
                                              print(comment);
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
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print(widget.id);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
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
