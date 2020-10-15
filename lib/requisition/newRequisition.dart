import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procurex/requisition/requisitions.dart';
import 'package:procurex/utils/decimalTextInputFormatter.dart';

class NewRequisition extends StatefulWidget {
  @override
  _NewRequisitionState createState() => _NewRequisitionState();
}

class _NewRequisitionState extends State<NewRequisition> {
  final _formKey = GlobalKey<FormState>();
  List<String> _items = ["gal", "wali", "Cimenti"];
  String dropdownValue, qty, comment;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Requisition'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    items: _items.map<DropdownMenuItem<String>>((String value) {
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Expected Date',
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
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Comments'),
                    onChanged: (value) => comment = value,
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(_dateText.text);
                        print(dropdownValue);
                        print(qty);
                        print(comment);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => Requisitions()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Text('Submit'),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
