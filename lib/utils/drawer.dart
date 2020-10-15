import 'package:flutter/material.dart';
import 'package:procurex/delivery/delivery.dart';
import 'package:procurex/order/order.dart';
import 'package:procurex/requisition/requisitions.dart';
import 'package:procurex/stock/stock.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          ListTile(
            title: Text('Requisitions'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Requisitions()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('Stock'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Stock()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('Delivery Log'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Delivery()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Order()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
