import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/utility/constants.dart';

class TransportPage extends StatefulWidget {
  @override
  _TransportPAgeState createState() => _TransportPAgeState();
}

class _TransportPAgeState extends State<TransportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Route'),
      ),
      body: Column(
        children: [
          _RowItem(),
          _RowItem(),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: Icon(CupertinoIcons.map_pin_ellipse),
                ),
                Text('Brooklyn Central', style: k16BoldStyle),
              ],
            ),
          ),
          _SubRowItem(),
          _SubRowItem(),
          _SubRowItem(isAssigned: true),
        ],
      ),
    );
  }
}

class _SubRowItem extends StatelessWidget {
  final bool isAssigned;

  _SubRowItem({this.isAssigned = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(CupertinoIcons.bus),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 15.0),
            child: Text('VH4584'),
          ),
          if (isAssigned) Text('Assigned', style: kBlueStyle),
          if (isAssigned) Spacer(),
          if (isAssigned)
            TextButton.icon(
              onPressed: () {},
              icon: Icon(CupertinoIcons.square_favorites),
              label: Text('View'),
            ),
          if (!isAssigned) Spacer(),
        ],
      ),
    );
  }
}
